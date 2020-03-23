import 'package:flutter/material.dart';
import '../Compare_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../classes/table.dart';
import '../presentation/my_icons.dart';
class Hospital_list extends StatefulWidget{
  @override
  HomePage createState() => HomePage();

}

Future<List<table>> fetchAlbum() async {
  List<table> list;
  String url='http://hospital-env.eba-rwfpssxq.us-east-2.elasticbeanstalk.com/api/';
  var response = await http.get(Uri.encodeFull(url));
  // If the server did return a 200 OK response, then parse the JSON.
  var data=json.decode(response.body);
  var rest=data["data"] as List;
  list=rest.map<table>((json)=> table.fromJson(json)).toList();
  print("List Size: ${list.length}");
  return list;

}
class HomePage extends State<Hospital_list>{
  Future<List<table>> futureAlbum;

  @override
  void initState() {
    super.initState();
    futureAlbum = fetchAlbum();
    // myController.addListener(_printLatestValue);
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home: new  Scaffold(
          resizeToAvoidBottomPadding: false,
      body:
       Column(
         children: <Widget>[
           CustomBarWidget(),
            Container(
                height: 75,
                color: Colors.grey[200],

             child: Row(
                 mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: <Widget>[

               FlatButton(
                 onPressed: () => {},
                 padding: EdgeInsets.all(10.0),
                 child: Column( // Replace with a Row for horizontal icon + text
                   children: <Widget>[
                     Icon(My.pill),
                     Padding(
                       padding: EdgeInsets.only(
                           top: 5.0
                       ),
                       child: Text("Drugs"),
                     )
                   ],
                 ),

               ),
                 FlatButton(
                   onPressed: () => {},
                   padding: EdgeInsets.all(10.0),
                   child: Column( // Replace with a Row for horizontal icon + text
                     children: <Widget>[
                       Icon(My.doctor),
                       Padding(
                         padding: EdgeInsets.only(
                             top: 5.0
                         ),
                         child: Text("Conditions"),
                       )
                     ],
                   ),
                 ),
               FlatButton(
                 onPressed: () => {},
                 padding: EdgeInsets.all(10.0),
                 child: Column( // Replace with a Row for horizontal icon + text
                   children: <Widget>[
                     Icon(My.clipboard),
                     Padding(
                       padding: EdgeInsets.only(
                         top: 5.0
                       ),
                     child: Text("Procedures"),
                     )

                   ],
                 ),
               ),
               FlatButton(
                 onPressed: () => {},
                 padding: EdgeInsets.all(10.0),
                 child: Column( // Replace with a Row for horizontal icon + text
                   children: <Widget>[
                     Icon(Icons.more_horiz),
                     Padding(
                       padding: EdgeInsets.only(
                           top: 5.0
                       ),
                       child: Text("More"),
                     )
                   ],
                 ),
               ),
             ],

           )

           ),
          Padding(
              padding: EdgeInsets.all(10.0),
          child: Text('Nearby Hospitals'
               ,style: TextStyle(
                 fontSize: 18.0,
                 color: Colors.black,)
             ),
          ),
           Expanded(

             child:

           FutureBuilder<List<table>>(
             future: futureAlbum,
             builder: (context, snapshot) {
               if (snapshot.hasData) {
                 return listViewWidget(snapshot.data);
               } else if (snapshot.hasError) {
                 return Text("${snapshot.error}");
               }

               // By default, show a loading spinner.
               return
                    Center(
                 child: CircularProgressIndicator(),
               );
             },
           ),
           )


         ],
      ),

      ),
    );
  }
}

Widget listViewWidget(List<table> article) {
  return Container(
    child: ListView.builder(
        itemCount: article.length,
        itemExtent: 80.0,
        padding: const EdgeInsets.all(5.0),
        itemBuilder: (context, position) {
          return Card(
            child: ListTile(
              title: Text(
                '${article[position].name}',
                style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
          );
        }),
  );
}









class CustomBarWidget extends StatelessWidget {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
   return Container(
        height: 140.0,
        child: Stack(
          children: <Widget>[
            Container(
              color: Colors.red,
              width: MediaQuery.of(context).size.width,
              height: 120.0,
              child: Center(
                child: Text(
                  "Hospitals",
                  style: TextStyle(color: Colors.white, fontSize: 18.0,fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Positioned(
              top: 85.0,
              left: 0.0,
              right: 0.0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.0),
                      border: Border.all(
                          color: Colors.grey.withOpacity(0.5), width: 1.0),
                      color: Colors.white),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          print("your menu action here");
                        },
                      ),
                      Expanded(
                          child: TextFormField(
                            readOnly: true,
                            enableInteractiveSelection: false,
                            focusNode: FocusNode(),
                            onTap:(){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Compare_screen()),
                              );
                            },
                            decoration: InputDecoration(
                              hintText: "Compare Prices",
                            ),
                          )
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),

    );
  }
}

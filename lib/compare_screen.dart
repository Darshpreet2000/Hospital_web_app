import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import './Models/hospital.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';

class Compare_screen extends StatefulWidget {
  Compare_screen({ Key key }) : super(key: key);
  @override
  _SearchListState createState() => new _SearchListState();

}
final myController = TextEditingController();

Future<List<hospital>> fetchAlbum(String text) async {
  List<hospital> list;
  print(text);
  String url='http://hospital-env.eba-rwfpssxq.us-east-2.elasticbeanstalk.com/api/search/'+text;
  var response = await http
      .post(Uri.encodeFull(url), body: json.encode(
    [
      {"name":"atlanticare-regional-medical-center"},
      {"name":"new-york-presbyterian-hospital"},
      {"name":"cooper-university-hospital"},
      {"name":"university-of-florida-health-shands"}
    ]
  ), headers: {"content-type": "application/json"});


  // If the server did return a 200 OK response, then parse the JSON.
    var data=json.decode(response.body);
    var rest=data["data"] as List;
    list=rest.map<hospital>((json)=> hospital.fromJson(json)).toList();
    print("List Size: ${list.length}");
        return list;

}


class _SearchListState extends State<Compare_screen> {
  Future<List<hospital>> futureAlbum;
  bool isLoading;
  @override
  void initState() {
    super.initState();
    isLoading=false;
   // myController.addListener(_printLatestValue);
  }
  Icon actionIcon = new Icon(Icons.search, color: Colors.white,);
  final key = new GlobalKey<ScaffoldState>();
  final TextEditingController _searchQuery = new TextEditingController();
  List<String> _list;
  bool _IsSearching=true;
  String _searchText = "";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: key,
      resizeToAvoidBottomInset : false,
      appBar: buildBar(context),
      body:
        FutureBuilder<List<hospital>>(
          future: futureAlbum,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return listViewWidget(snapshot.data);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            // By default, show a loading spinner.
            return  isLoading
                ? Center(
              child: CircularProgressIndicator(),
            ):
            Center(
              child:Text('Enter Procedure to Compare Prices',
                style: TextStyle(color: Colors.black, fontSize: 16.0),

            ),);
          },
        ),


    );
  }
  Widget listViewWidget(List<hospital> article) {
    return Container(
      child: ListView.builder(
          itemCount: article.length,
          itemExtent: 110.0,
          padding: const EdgeInsets.all(5.0),
          itemBuilder: (context, position) {
            return Card(
              child: ListTile(
                title: Text(
                  '${article[position].description}',
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text('${article[position].name}\nCharge Type: ${article[position].charge_type}\nDate Updated: ${article[position].DateUpdated}'
                    ,style: TextStyle(
                       fontSize: 14.0,
                      color: Colors.black,)),
                isThreeLine: true,
                trailing: Text('${article[position].price}'),

              ),
            );
          }),
    );
  }


  Widget buildBar(BuildContext context) {
    return new AppBar(
       centerTitle: true,
        title: new TextField(
          autofocus: true,
          textAlign: TextAlign.left,
            onSubmitted: (String str){
              setState((){
                isLoading=true;
                futureAlbum = fetchAlbum(str);
              });
            },
          style: new TextStyle(
            color: Colors.white,
          ),
          decoration: new InputDecoration(
            contentPadding: EdgeInsets.only(
             bottom:5.0
            ),
            prefixIcon: new IconButton(icon: Icon(Icons.search,color: Colors.white,), onPressed: null),
            hintText: "Compare Prices",
              hintStyle: new TextStyle(color: Colors.grey[50],fontSize: 16.0),
              suffix: new IconButton(icon: Icon(Icons.filter_vintage,color: Colors.white,), onPressed: null),
              )
          ),
    );
  }



}



import 'package:flutter/material.dart';
import 'BottomNav/Home.dart';
import 'BottomNav/News.dart';
import 'BottomNav/Saved.dart';
void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return MyAppState();
  }

}


class MyAppState extends State<MyApp> {
  int _SelectedPage=0;
  final pageOptions=[
    Hospital_list(),
    NewsPage(),
    SavedPage()
      ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'WebScrap',
        theme: ThemeData(
          primarySwatch: Colors.teal,
        ),
        home: Scaffold(
          body: pageOptions[_SelectedPage],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: _SelectedPage,
              onTap: (int index){
                setState(() {
                 _SelectedPage=index;
                });
              },
              items: [
            new BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
            new BottomNavigationBarItem(icon: Icon(Icons.near_me),title: Text('News')),
            new BottomNavigationBarItem(icon: Icon(Icons.save_alt),title: Text('Saved'))
          ]),
        ));
  }
}

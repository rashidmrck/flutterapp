import 'package:flutter/material.dart';
import './screens/screen_list.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Mr CK App",
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: NoteList()
    );
  }
}
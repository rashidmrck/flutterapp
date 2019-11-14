import 'package:flutter/material.dart';
import 'package:MrCK_NoteApp/screens/screen_list.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
      debugShowCheckedModeBanner: false,
      home: NoteList(),
    );
  }
}
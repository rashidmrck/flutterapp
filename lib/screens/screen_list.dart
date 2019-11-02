import 'package:flutter/material.dart';
import 'package:mrck_app/screens/note_detail.dart';
import 'package:mrck_app/model/note.dart';
import 'package:mrck_app/utils/datebase_helper.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class NoteList extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _NoteList();
  }
}

class _NoteList extends State<NoteList> {


  DatabaseHelper databaseHelper = DatabaseHelper();
  int count = 0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: getListView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          navigateEditNote("New Note");
        },
      ),
    );
  }

  ListView getListView() {
    TextStyle titlestyle = Theme.of(context).textTheme.subhead;
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            color: Colors.white,
            elevation: 2.0,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.yellowAccent,
                child: Icon(Icons.keyboard_arrow_right),
              ),
              title: Text(
                "Demo Title",
                style: titlestyle,
              ),
              subtitle: Text('Demo Sub title'),
              trailing: Icon(
                Icons.delete,
                color: Colors.grey,
              ),
              onTap: () {
                navigateEditNote("Edit Note");
              },
            ),
          );
        });
  }
  void navigateEditNote(String title){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return EditNote(title);
    }));
  }
}
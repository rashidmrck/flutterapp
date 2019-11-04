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
  List<Note> notelist;
  int count = 0;

  @override
  Widget build(BuildContext context) {

    if(notelist == null){
      notelist = List<Note>();
      updatelistveiw();
    }

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: getListView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          navigateEditNote(Note('','', 2), 'New Note');
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
                backgroundColor: getPriorityColor(this.notelist[position].priority),
                child: getPriorityIcon(this.notelist[position].priority),
              ),
              title: Text(
                this.notelist[position].title,
                style: titlestyle,
              ),
              subtitle: Text(this.notelist[position].date),
              trailing: GestureDetector(
                onTap: (){
                  _delete(context, this.notelist[position]);
                },
                child: Icon(
                  Icons.delete,
                  color: Colors.grey,
                ),
              ),
              onTap: () {
                navigateEditNote(this.notelist[position],"Edit Note");
              },
            ),
          );
        });
  }
  Color getPriorityColor(int priority){
    switch(priority){
      case 1:
        return Colors.red;
        break;
      case 2:
        return Colors.yellow;
        break;
      default:
        return Colors.yellow;
    }
  }

  Icon getPriorityIcon(int priority){
    switch(priority){
      case 1:
        return Icon(Icons.play_arrow);
        break;
      case 2:
        return Icon(Icons.keyboard_arrow_right);
        break;
      default:
        return Icon(Icons.keyboard_arrow_right);
    }
  }

  void _delete(BuildContext context,Note note)async{
    int result = await databaseHelper.deletenote(note.id);

    if(result != 0){
      _showSnackBar(context, 'Note Deleted Successfully');
      updatelistveiw();
    }
  }

  void _showSnackBar(BuildContext context,String text){
    final snackbar = SnackBar(content: Text(text));
    Scaffold.of(context).showSnackBar(snackbar);
  }

  void navigateEditNote(Note note, String title){
    Navigator.push(context, MaterialPageRoute(builder: (context){
      return EditNote(title,note);
    }));
  }
  void updatelistveiw(){
    final Future<Database> dbfuture = databaseHelper.initializeDatabase();
    dbfuture.then((database){
      Future<List<Note>> noteListFuture = databaseHelper.getNotList();
      noteListFuture.then((notList){
        setState(() {
          this.notelist = notList;
          this.count = notList.length;
        });
      });
    });
  }
}
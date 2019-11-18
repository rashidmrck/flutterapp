import 'package:MrCK_NoteApp/screens/note_detail.dart';
import 'package:flutter/material.dart';
import 'package:MrCK_NoteApp/utils/database_helper.dart';
import 'package:MrCK_NoteApp/model/note.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:sqflite/sqflite.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  DatabaseHelper databaseHelper = DatabaseHelper();
  List<Note> noteList;
  var count = 0;

  @override
  Widget build(BuildContext context) {
    if (noteList == null) {
      noteList = List<Note>();
      updateListView();
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            navigateToDetail(Note('','',2), "Add Note");
          }),
      body: getNoteListView(),
    );
  }

  ListView getNoteListView() {
    return ListView.builder(
        itemCount: count,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            child: ListTile(
              onTap: () {
                navigateToDetail(this.noteList[position], 'Edit Note');
              },
              leading: CircleAvatar(
                backgroundColor:
                    priorityColor(this.noteList[position].priority),
                child: priorityIcon(this.noteList[position].priority),
              ),
              title: Text(this.noteList[position].title),
              subtitle: Text(this.noteList[position].date),
              trailing: InkWell(
                  onTap: () {
                    _delete(context, this.noteList[position]);
                    updateListView();
                  },
                  child: Icon(Icons.delete)),
            ),
          );
        });
  }

  Color priorityColor(int priority) {
    switch (priority) {
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

  Icon priorityIcon(int priority) {
    switch (priority) {
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

  void _delete(BuildContext context, Note note) async {
    int result = await databaseHelper.deleteNote(note.id);

    if (result != 0) {
      _showsnackbar(context, 'Note deleted Successfully');
    }
  }

  void _showsnackbar(BuildContext context, String message) {
    final snackbar = SnackBar(
      content: Text(message),
    );
    Scaffold.of(context).showSnackBar(snackbar);
  }

  void navigateToDetail(Note note,String title) async{
    bool result = await Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Note_Detail(note,title);
    }));
    if(result = true){
      updateListView();
    }
  }

  void updateListView() {
    final Future<Database> dbFuture = databaseHelper.initializeDatabase();
    dbFuture.then((database) {
      Future<List<Note>> noteListFuture = databaseHelper.getNoteList();
      noteListFuture.then((noteList) {
        setState(() {
          this.noteList = noteList;
          this.count = noteList.length;
        });
      });
    });
  }
}

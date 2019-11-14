import 'package:MrCK_NoteApp/screens/note_detail.dart';
import 'package:flutter/material.dart';

class NoteList extends StatefulWidget {
  @override
  _NoteListState createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    var count = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            navigate(context,"Add Note");
          }),
      body: ListView(
        children: <Widget>[
          Card(
            child: ListTile(
              onTap: (){
                navigate(context, 'Edit Note');
              },
              leading: CircleAvatar(
                backgroundColor: Colors.yellow,
                child: Icon(Icons.keyboard_arrow_right),
              ),
              title: Text('Note Title'),
              subtitle: Text('Date'),
              trailing: InkWell(
                onTap: (){},
                  child: Icon(Icons.delete)),
            ),
          )
        ],
      ),
    );
  }

  void navigate(BuildContext context, String title) {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Note_Detail(title);
    }));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:MrCK_NoteApp/utils/database_helper.dart';
import 'package:MrCK_NoteApp/model/note.dart';
import 'package:intl/intl.dart';

class Note_Detail extends StatefulWidget {
  final String title;
  final Note note;

  Note_Detail(this.note, this.title);

  @override
  _Note_DetailState createState() => _Note_DetailState(this.note,this.title);
}

class _Note_DetailState extends State<Note_Detail> {
  var item = ['Low', 'High'];

  final String title;
  final Note note;
  DatabaseHelper helper = DatabaseHelper();

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  _Note_DetailState(this.note, this.title);

  @override
  Widget build(BuildContext context) {

    titleController.text = note.title;
    descriptionController.text = note.description;

    return Scaffold(
      appBar: AppBar(
        title: Text(this.title),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 300,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButton(
                    items: item.map((String itemlist) {
                      return DropdownMenuItem<String>(
                        value: itemlist,
                        child: Text(itemlist),
                      );
                    }).toList(),
                    onChanged: (String selected) {
                      setState(() {
                        updatePriorityAsInt(selected);
                      });
                    },
                    value: updatePriorityAsString(note.priority),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: titleController,
              onChanged: (value){
                updateTitle();
              },
              decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: descriptionController,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              textAlignVertical: TextAlignVertical(y: -0.92),
              onChanged: (value){
                updateDescription();
              },
              decoration: InputDecoration(
                  labelText: 'Description',
                  alignLabelWithHint: true,
                  contentPadding: EdgeInsets.only(bottom: 300, left: 5.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0))),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 45,
                    child: RaisedButton(
                        color: Colors.deepPurple,
                        child: Text(
                          'Save',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        onPressed: () {
                          _save();
                        })),
              )),
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                    height: 45,
                    child: RaisedButton(
                        child: Text(
                          'Delete',
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                        color: Colors.deepPurple,
                        onPressed: () {
                          _delete();
                        })),
              )),
            ],
          ),
        ],
      ),
    );
  }
  void updatePriorityAsInt(String value){
    switch(value){
      case 'High':
        note.priority = 1;
        break;
      case 'Low':
        note.priority = 2;
        break;
    }
  }
  String updatePriorityAsString(int value){
    String priority;
    switch(value){
      case 1:
        priority = item[0];
        break;
      case 2:
        priority = item[1];
        break;
    }
    return priority;
  }
  void updateTitle(){
    titleController.text = note.title;
  }
  void updateDescription(){
    descriptionController.text = note.description;
  }
  void _save()async{
    moveToLastScreen();
    int result;
    note.date = DateFormat.yMMMd().format(DateTime.now());
    if(note.id != null){
      result = await helper.updateNote(note);
    }
    else{
      result = await helper.insertNote(note);
    }
    if(result != 0){
      _showAlertDialig('Status', 'Note Saved Successfully');
    }
    else{
      _showAlertDialig('Status', 'Error to Save Note');
    }
  }

  void _delete()async{
    moveToLastScreen();
    int result;
    if(note.id == null){
      _showAlertDialig('Status', 'No Note was deleted');
    }
    result =  await helper.deleteNote(note.id);

    if(result != 0){
      _showAlertDialig('Status', 'Note was Deleted Successfully');
    }
    else{
      _showAlertDialig('Status', 'Error to Delete Note');
    }
  }
  void _showAlertDialig(String title,String content){

    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(content),
    );
    showDialog(
        context: context,
        builder: (_) => alertDialog
    );
  }
  void moveToLastScreen(){
    Navigator.pop(context,true);
  }
}

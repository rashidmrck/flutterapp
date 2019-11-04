import 'package:flutter/material.dart';
import 'package:mrck_app/model/note.dart';
import 'package:mrck_app/utils/datebase_helper.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class EditNote extends StatefulWidget {
  final String appbartitle;
  final Note note;


  EditNote(this.appbartitle,this.note);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditNote(appbartitle,note);
  }
}

class _EditNote extends State<EditNote> {

  String appbartitle;
  Note note;

  DatabaseHelper helper = DatabaseHelper();

  _EditNote(this.appbartitle,this.note);

  var _priority = ['High', 'Low'];
  String _selected = 'High';
  TextEditingController titleController = TextEditingController();
  TextEditingController discriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textstyle = Theme.of(context).textTheme.title;

    titleController.text = note.title;
    discriptionController.text = note.discription;

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: Icon(Icons.arrow_back),
            onPressed: (){
              movetolastscreen();
            }),
        title: Text(appbartitle),
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            child: ListTile(
              title: DropdownButton(
                items: _priority.map((String items) {
                  return DropdownMenuItem<String>(
                      value: items, child: Text(items));
                }).toList(),
                style: textstyle,
                onChanged: (select) {
                  setState(() {
                    updatePriorityAsInt(select);
                  });
                },
                value: getPriorityAsString(note.priority),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              style: textstyle,
              controller: titleController,
              decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: textstyle,
                  hintText: "Enter Title",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              onChanged: (value) {},
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              style: textstyle,
              controller: discriptionController,
              decoration: InputDecoration(
                  labelText: "Title",
                  labelStyle: textstyle,
                  hintText: "Enter Title",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              onChanged: (value) {},
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 15, bottom: 15),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(left: 10, right: 2),
                  child: SizedBox(
                    height: 45,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text("Save"),
                      onPressed: () {},
                    ),
                  ),
                )),
                Expanded(
                    child: Padding(
                  padding: EdgeInsets.only(right: 10, left: 2),
                  child: SizedBox(
                    height: 45,
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text("Delete"),
                      onPressed: () {},
                    ),
                  ),
                )),
              ],
            ),
          )
        ],
      ),
    );
  }
  void movetolastscreen(){
    Navigator.pop(context);
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
  String getPriorityAsString(int value){
    String priority;
    switch(value){
      case 1:
        priority = _priority[0];
        break;
      case 2:
        priority = _priority[1];
        break;
    }
    return priority;
  }
}

import 'package:flutter/material.dart';
import 'package:mrck_app/model/note.dart';
import 'package:mrck_app/utils/datebase_helper.dart';
import 'dart:async';
import 'package:sqflite/sqflite.dart';

class EditNote extends StatefulWidget {
  String appbartitle;


  EditNote(this.appbartitle);

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _EditNote(appbartitle);
  }
}

class _EditNote extends State<EditNote> {

  String appbartitle;

  _EditNote(this.appbartitle);

  var _priority = ['High', 'Low'];
  String _selected = 'High';
  TextEditingController title = TextEditingController();
  TextEditingController note = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle textstyle = Theme.of(context).textTheme.title;

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
                    this._selected = select;
                  });
                },
                value: _selected,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: TextField(
              style: textstyle,
              controller: title,
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
              controller: title,
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
}

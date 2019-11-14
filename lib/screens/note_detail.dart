import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Note_Detail extends StatefulWidget {
  String title;

  Note_Detail(this.title);

  @override
  _Note_DetailState createState() => _Note_DetailState(title);
}

class _Note_DetailState extends State<Note_Detail> {
  var item = ['Low', 'High'];

  String title;
  String defaultselect = 'Low';

  _Note_DetailState(this.title);

  @override
  Widget build(BuildContext context) {
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
                        this.defaultselect = selected;
                      });
                    },
                    value: defaultselect,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLines: null,
              keyboardType: TextInputType.multiline,
              textAlignVertical: TextAlignVertical(y: -0.92),
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
                        onPressed: () {})),
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
                        onPressed: () {})),
              )),
            ],
          ),
        ],
      ),
    );
  }
}

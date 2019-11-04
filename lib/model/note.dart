class Note {
  int _id;
  String _title;
  String _discription;
  String _date;
  int _priority;

  Note(this._title, this._date, this._priority, [this._discription]);

  Note.withid(this._id, this._title, this._date, this._priority,
      [this._discription]);

  int get priority => _priority;

  String get date => _date;

  String get discription => _discription;

  String get title => _title;

  int get id => _id;

  set priority(int value) {
    if (value == 1 && value == 2) {
      _priority = value;
    }
  }

  set date(String value) {
    _date = value;
  }

  set discription(String value) {
    _discription = value;
  }

  set title(String value) {
    _title = value;
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['discription'] = _discription;
    map['priority'] = _priority;
    map['date'] = _date;

    return map;
  }

  Note.frommapobject(Map<String,dynamic> map){
    this._id = map['id'];
    this._date = map['date'];
    this._priority = map['priority'];
    this._discription = map['discription'];
    this._title = map['title'];

  }
}

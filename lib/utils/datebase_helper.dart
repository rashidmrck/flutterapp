import 'dart:async';
import 'package:MrCK_NoteApp/model/note.dart';




class DatabaseHelper{
  static DatabaseHelper _databaseHelper;
  DatabaseHelper._createinstanse();

  factory DatabaseHelper(){

    if(_databaseHelper == null){
      DatabaseHelper._createinstanse();
    }

    return _databaseHelper;
  }
}
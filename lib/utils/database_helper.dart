import 'dart:io';
import 'package:MrCK_NoteApp/model/note.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';




class DatabaseHelper{
  static DatabaseHelper _databaseHelper;
  static Database _database;

  DatabaseHelper._createInstance();

  String noteTable = 'noteTable';
  String colId = 'Id';
  String colTitle = 'Title';
  String colDiscription = 'Discription';
  String colPriority = 'Priority';
  String colDate = 'Date';


  factory DatabaseHelper(){

    if(_databaseHelper == null){
      DatabaseHelper._createInstance();
    }

    return _databaseHelper;
  }

  Future<Database> get database async{

    if(_database == null) {
      _database = await initializeDatabase();
    }

    return _database;
  }

  Future<Database> initializeDatabase()async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path+'note1.db';

    var notedDatabase  = await openDatabase(path,version: 1,onCreate: _createTable);
    return notedDatabase;
  }

  void _createTable(Database db, int newVersion)async{
    await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, $colDiscription TEXT, $colPriority INTEGER, $colDate TEXT)');

  }
   Future<List<Map<String,dynamic>>> getNoteMapList()async{
    Database db = await this.database;
    var result = db.query(noteTable,orderBy: '$colPriority ACS');
    return result;
  }
  Future<int> insertNote(Note note)async{
    Database db = await this.database;
    var result = db.insert(noteTable, note.tomap());
    return result;
  }

  Future<int> updateNote(Note note)async{
    Database db = await this.database;
    var result = db.update(noteTable, note.tomap(),where: '$colId = ?',whereArgs: [note.id]);
    return result;
  }
  Future<int> deleteNote(int id)async{
    Database db = await this.database;
    var result = db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
    return result;
  }
  Future<int> getcount()async{
    Database db = await this.database;
    List<Map<String,dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $noteTable');
    int result = Sqflite.firstIntValue(x);
    return result;
  }
  Future<List<Note>> getNoteList()async{
    var noteMapList = await getNoteMapList();

    int count = noteMapList.length;

    List<Note> noteList = List<Note>();

    for(int i = 0; i < count; i++){
      noteList.add(Note.fromMapObject(noteMapList[i]));
    }
    return noteList;
  }
}
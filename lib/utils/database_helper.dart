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
  String colDescription = 'Description';
  String colPriority = 'Priority';
  String colDate = 'Date';


  factory DatabaseHelper(){

    if(_databaseHelper == null){
      _databaseHelper = DatabaseHelper._createInstance();
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
    String path = directory.path+'note.db';

    var notedDatabase  = await openDatabase(path,version: 1,onCreate: _createDb);
    return notedDatabase;
  }

  void _createDb(Database db, int newVersion) async {

    await db.execute('CREATE TABLE $noteTable($colId INTEGER PRIMARY KEY AUTOINCREMENT, $colTitle TEXT, '
        '$colDescription TEXT, $colPriority INTEGER, $colDate TEXT)');
  }
  Future<List<Map<String, dynamic>>> getNoteMapList() async {
    Database db = await this.database;
    var result = await db.query(noteTable, orderBy: '$colPriority ASC');
    return result;
  }
  Future<int> insertNote(Note note)async{
    Database db = await this.database;
    var result = await db.insert(noteTable, note.toMap());
    return result;
  }

  Future<int> updateNote(Note note)async{
    Database db = await this.database;
    var result = await db.update(noteTable, note.toMap(),where: '$colId = ?',whereArgs: [note.id]);
    return result;
  }
  Future<int> deleteNote(int id)async{
    Database db = await this.database;
    var result = await db.rawDelete('DELETE FROM $noteTable WHERE $colId = $id');
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
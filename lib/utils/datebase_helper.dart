import 'package:mrck_app/model/note.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static DatabaseHelper _databasehelper;
  static Database _database;

  String noteTable = 'note_table';
  String colid = 'id';
  String coltitle = 'title';
  String coldisctription = 'discription';
  String colpriority = 'priority';
  String coldate = 'date';


  DatabaseHelper._createinstance();

  factory DatabaseHelper() {
    if (_databasehelper == null) {
      _databasehelper = DatabaseHelper._createinstance();
    }
    return _databasehelper;
  }

  Future<Database> get database async{
    if(_database == null) {
      _database = await initializeDatabase();
    }
    return _database;
  }

  Future<Database> initializeDatabase()async{
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'nots.db';

    var notedatabase = await openDatabase(path,version: 1,onCreate: _createDb);
    return notedatabase;
  }

  void _createDb(Database db, int newvirsion) async {
    await db.execute(
        'CREATE TABE $noteTable($colid INTEGER PRYMARY KEY AUTOINCREMENT, $coltitle TEXT, $coldisctription TEXT, $colpriority INTEGER, $coldate TEXT)');
  }

  Future<List<Map<String, dynamic>>> getnotMapList()async{
    Database db = await this.database;
    
    var result = db.query(noteTable, orderBy: '$colpriority ASC');

    return result;
  }

  Future<int> insertnote(Note note)async{
    Database db = await this.database;
    var result = db.insert(noteTable, note.toMap());

    return result;
  }

  Future<int> updatenote(Note note)async{
    Database db = await this.database;

    var result = db.update(noteTable, note.toMap(),where: '$colid = ?',whereArgs: [note.id]);
    return result;
  }

  Future<int> deletenote(int id)async{
    Database db = await this.database;
    
    var result = db.rawDelete('DELETE FROM $noteTable WHERE $colid = $id');

    return result;
  }

  Future<int> getcount()async{
    Database db = await this.database;

    List<Map<String,dynamic>> x = await db.rawQuery('SELECT COUNT (*) from $noteTable');

    int result = Sqflite.firstIntValue(x);

    return result;
  }

  Future<List<Note>> getNotList()async{
    var notMapList = await getnotMapList();
    int count = notMapList.length;

    List<Note> noteList = List<Note>();

    for(int i =0; i < count; i++){
      noteList.add(Note.frommapobject(notMapList[i]));
    }
    return noteList;
  }

}

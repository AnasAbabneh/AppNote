import 'package:notes/model/note.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path/path.dart';

class DatabaseHelper {
  final String tableNote = 'noteTable';

  final String columnId = 'id';
  final String columnTitle = 'title';
  final String columnBody = 'body';
  final String columnTime = 'time';

  //import
  static Database _db;

  //check if db found
  Future<Database> get db async {
    if (_db != null) {
      return _db;
    }
    _db = await initDb();

    return _db;
  }

  //create db
  initDb() async {
    String databasePath = await getDatabasesPath();
    String path = join(databasePath, 'notesanas.db');
    var db = await openDatabase(path , version: 1 , onCreate: _onCreate);
    return db;
  }



  void _onCreate(Database db , int newVersion) async{
    var sql = 'CREATE TABLE $tableNote ($columnId INTEGER PRIMARY KEY,'
        '$columnTime TEXT ,$columnTitle TEXT ,'
        '$columnBody TEXT )';
    await db.execute(sql);
  }


  Future<int> saveNote(Note note) async{
    var dbClient = await db;
    var result = await dbClient.insert(  tableNote , note.toMap() );
    return result;
  }


  Future<List> getAllNotes() async{
    var dbClient = await db;
    var result = await dbClient.query(
        tableNote ,
        columns: [columnId,columnBody,columnTime,columnTitle]
    );
    return result.toList();
  }


  Future<int> getCount() async{
    var dbClient = await db;
    return Sqflite.firstIntValue(await dbClient.rawQuery('SELECT COUNT(*) FROM $tableNote'));
  }


  Future<Note> getNote(int id) async{
    var dbClient = await db;
    List<Map> result = await dbClient.query(
        tableNote ,
        columns: [columnId,
          columnTitle,columnBody,columnTime],where: '$columnId = ?',whereArgs: ['id']
    );

    if(result.length > 0){
      return new Note.fromMap(result.first);
    }

    return null;
  }

  Future<int> updateNote(Note note)async{
    var dbClient = await db;
    return await dbClient.update(
        tableNote , note.toMap(), where: '$columnId = ?',whereArgs: [ note.id ]
    );
  }


  Future<int> deleteNote(int id)async{
    var dbClient = await db;
    return await dbClient.delete(
        tableNote ,   where: '$columnId = ?',whereArgs: [id]
    );
  }


  Future  close() async{
    var dbClient = await db;
    return await dbClient.close();
  }


}


import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider {
  static final _dbname = "persons.db";
  static final _dbversion = 1;

  static final table = "my_table";

  static final columnId = "id";
  static final columnName = "name";
  static final columnage = "age";

  DBProvider._privateConstructor();

  static final DBProvider instance = DBProvider._privateConstructor();

  static Database _database;

  Future<Database> get dadabase async {
    if (_database != null) return _database;

    _database = await initDatabase();
    return _database;
  }

  initDatabase() async {
    Directory documentdirectory = await getApplicationDocumentsDirectory();
    String path = join(documentdirectory.path, _dbname);
    return await openDatabase(path, version: _dbversion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute("""
 CREATE TABLE $table (
   $columnId INTEGER PRIMARY KEY,
   $columnName TEXT NOT NULL,
   $columnage INTEGER NOT NULL
 )
         """);
  }

  // custom function for crud operation

  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.dadabase;
    return await db.insert(table, row);
  }

  Future<List<Map<String, dynamic>>> queryall() async {
    Database db = await instance.dadabase;
    return await db.query(table);
  }

  Future<List<Map<String, dynamic>>> queryBasic(int age) async {
    Database db = await instance.dadabase;
    var result = await db.query(table, where: "age > ?", whereArgs: [age]);
    return result;
  }

  Future<int> delete(int id) async {
    Database db = await instance.dadabase;
    var result = await db.delete(table, where: "id=?", whereArgs: [id]);
    return result;
  }

  Future<int> update(int id) async {
    Database db = await instance.dadabase;
    var result = await db.update(table, {"name": "Niku", "age": 24},
        where: "id=?", whereArgs: [id]);
    return result;
  }
}

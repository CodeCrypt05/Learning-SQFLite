import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  // Declare database name
  static final _databaseName = 'person.db';
  // Declare database version
  static final _databaseVersin = 1;
  // Declare table name
  static final table = "my_table";

  // Create columns for table
  static final columnId = 'id';
  static final columnName = 'name';
  static final columnAge = 'age';

  //Create database
  static Database? _database;

  //  By making the constructor private, you prevent external code from creating new instances,
  //and you provide a controlled way to access the single instance.
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database?> get database async {
    // check dayabase available or not
    if (_database != null) return _database;

    // initialize database
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    // to create database make directory
    Directory documentDirectory = await getApplicationDocumentsDirectory();
    // create path to join database to directory
    String path = join(documentDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersin, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $table (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT NOT NULL,
        $columnAge TEXT NOT NULL
      )
      ''');
  }

  // creating insert function where i insert rows and get id as of that rows
  Future<int> insert(Map<String, dynamic> row) async {
    Database? db = await instance.database;
    return await db!.insert(table, row);
  }

  // creating function to call all rows of table
  Future<List<Map<String, dynamic>>> getAllData() async {
    Database? db = await instance.database;
    return await db!.query(table);
  }

  // creating function to call specific row in table
  Future<List<Map<String, dynamic>>> querySpecific(int age) async {
    Database? db = await instance.database;
    var result = await db!.query(table, where: "age > ?", whereArgs: [age]);
    // er can perform same operation using raw query
    var res = await db!.rawQuery('SELECT * FROM my_table WHERE AGE > ?', [age]);
    return result;
  }

  // delete row from table
  Future<int> deleteData(int id) async {
    Database? db = await instance.database;
    var res = await db!.delete(table, where: 'id = ?', whereArgs: [id]);
    return res;
  }

  // update data in row
  Future<int> update(int id) async {
    Database? db = await instance.database;
    var result = await db!.update(table, {"name": "Vaibhav", "age": 6},
        where: "id = ?", whereArgs: [id]);
    return result;
  }
}

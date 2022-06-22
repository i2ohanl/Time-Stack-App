import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:time_tracker/model/history.dart';

class HistoryDatabase {
  static final HistoryDatabase instance = HistoryDatabase._init();

  static Database? _database;

  HistoryDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('notes.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const integerType = 'INTEGER NOT NULL';
    const textType = 'TEXT NOT NULL';

    await db.execute('''
CREATE TABLE $tableHistory (
  ${HistoryFields.id} $idType,
  ${HistoryFields.productive} $integerType,
  ${HistoryFields.unproductive} $integerType,
  ${HistoryFields.date} $textType
  )
''');
  }

  Future<History> create(History history) async {
    final db = await instance.database;

    final id = await db.insert(tableHistory, history.toJson());
    return history.copy(id: id);
  }

  Future<History> readHistory(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableHistory,
      columns: HistoryFields.values,
      where: '${HistoryFields.id} = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return History.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<History>> readAllHistories() async {
    final db = await instance.database;
    
    const orderBy = '${HistoryFields.date} DSC';
    final result = await db.query(tableHistory, orderBy: orderBy);

    return result.map((json) => History.fromJson(json)).toList();
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}
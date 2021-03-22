import 'package:aimedlabtask/ControllerPage/Model/HistoryModel.dart';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:path/path.dart';

class DBHelper {
  int listLength;
  bool len = false;
  static final DBHelper _instance = DBHelper.internal();
  factory DBHelper() => _instance;
  DBHelper.internal();
  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initDb();
    return _database;
  }

  Future<Database> initDb() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "data.db");
    var theDb = await openDatabase(path, version: 2, onCreate: _onCreate);
    return theDb;
  }

  void _onCreate(Database db, int version) async {
    // When creating the db, create the table
    await db.execute(
        "CREATE TABLE History(uniqueid INTEGER PRIMARY KEY,advice TEXT,id INTEGER,time TEXT)");
    print("Created tables");
  }

  void saveSlip(HistoryModel historyModel) async {
    var dbClient = await database;
    var batch = dbClient.batch();
    batch.insert("History", {
      "uniqueId": historyModel.uniqueId,
      "advice": historyModel.advice,
      "id": historyModel.id,
      "time": historyModel.time
    });
    batch.commit();
    print("Added");
  }

  Future<List<HistoryModel>> getAllHistory() async {
    var dbClient = await database;
    List<Map> list = await dbClient.rawQuery('SELECT * FROM History');
    List<HistoryModel> historyTable = new List();
    listLength = list.length;
    if (list.length > 0) {
      len = true;
    }
    int i = 0;
    for (i; i < listLength; i++) {
      print(i);
      historyTable.add(new HistoryModel(
          uniqueId: list[i]['uniqueid'],
          advice: list[i]['advice'],
          id: list[i]['id'],
          time: list[i]['time']));
    }
    return historyTable;
  }
}

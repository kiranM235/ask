import 'dart:io';
import 'package:ask/src/core/constants.dart';
import 'package:ask/src/models/item_model.dart';
import 'package:ask/src/repo/sources.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as Path;
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';


class AskDbProvider implements Source, Cache {
  Database? _db;

  AskDbProvider() {
    _init();
  }
  Future<void> _init() async{
    /// 1. Need a path to where our database resides
    Directory directory = await getApplicationDocumentsDirectory();
    final dbPath = Path.join(directory.path, DB_NAME);
    /// 2 . Either open a existing connection to db or create a database and get the connection

    _db = await openDatabase(
        dbPath,
        version: 1,
        onCreate: (Database db, int version){
          Batch batch = db.batch();
          batch.execute(
              """
              CREATE TABLE $ASK_TABLE (
                id INTEGER PRIMARY KEY,
                by TEXT,
                descendants INTEGER,
                score INTEGER,
                time INTEGER,
                title TEXT,
                url TEXT,
                type TEXT,
                text TEXT,
                kids BLOB
              )
            """
          );
          batch.commit();
        }
    );
  }

  /// fetch an item with the given id
  @override
  Future<ItemModel?> fetchItem(int id) async {
    if(_db == null) await _init();
    final data = await _db!.query(ASK_TABLE,where: "id = ?", whereArgs: [id]);
    /// select * from news where id = $id
    if(data.isEmpty) return null;
    return ItemModel.fromDb(data.first);

  }
  /// insert an item model
  @override
  Future<int> insertItem(ItemModel item) async {
    if(_db == null) await _init();
    return _db!.insert(ASK_TABLE, item.toDb(),
        conflictAlgorithm: ConflictAlgorithm.replace
    );

    /// insert into news(id, title, url...) values(1, 'some title', 'https://we.')
  }

  @override
  Future<List<int>> fetchTopIds() {
    // TODO: implement fetchTopIds
    throw UnimplementedError();
  }

  @override
  Future clearDatabase() async {
    if (_db == null) await _init();
    await _db!.delete(ASK_TABLE);
  }
}
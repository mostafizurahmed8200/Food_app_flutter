import 'package:e_commerce/model/salad_basket_sql.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  //Create DB and Table
  static Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'SaladDB.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE SaladItem(saladImage TEXT, saladName TEXT, saladPack TEXT, saladPrice TEXT)",
        );
      },
      version: 1,
    );
  }

  //Insert DB
  static Future<void> insertSaladTable(
      SaladBasketSqlModel saladBasketSqlModel) async {
    final Database db = await database();

    await db.insert(
      "SaladItem",
      saladBasketSqlModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
}

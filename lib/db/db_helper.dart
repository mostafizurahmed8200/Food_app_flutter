import 'package:food_apps/model/salad_basket_sql.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  //Create DB and Table
  static Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'SaladDB.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE SaladItemTbl(id INTEGER PRIMARY KEY AUTOINCREMENT , saladImage TEXT, saladName TEXT, saladPack TEXT, saladPrice TEXT)",
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
      'SaladItemTbl',
      saladBasketSqlModel.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  //Retrive Database Value
  static Future<List<SaladBasketSqlModel>> getSaladItems() async {
    final Database db = await database();
    final List<Map<String, dynamic>> maps = await db.query('SaladItemTbl');
    return List.generate(maps.length, (i) {
      return SaladBasketSqlModel(
        id: maps[i]['id'],
        saladImage: maps[i]['saladImage'],
        saladName: maps[i]['saladName'],
        saladPack: maps[i]['saladPack'],
        saladPrice: maps[i]['saladPrice'],
      );
    });
  }

  //Delete Item from Table--
  static Future<void> deleteSaladItem(int id) async {
    final Database db = await database();
    await db.delete(
      'SaladItemTbl',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  //get total price value
  static Future<int> getTotalPriceValue() async {
    final Database db = await database();
    final List<Map<String, dynamic>> result =
        await db.rawQuery('SELECT SUM(saladPrice) AS total FROM SaladItemTbl');
    int total = result[0]['total'];
    return total;
  }
}

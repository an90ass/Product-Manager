import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/product.dart';

class DbHelper {
  Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initilaizeDb();
    }
    return _db;
  }

  Future<Database?> initilaizeDb() async {
    String dbPath = join(await getDatabasesPath(), "etrade.db");
    var eTradeDb = await openDatabase(dbPath, version: 1, onCreate: createdb);
    return eTradeDb;
  }

  void createdb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE products(
        id INTEGER PRIMARY KEY, 
        productName TEXT, 
        description TEXT, 
        unitPrice REAL
      )
    ''');
  }

  Future<List<Product>> getProducts() async {
    Database? db = await this.db;
    var result = await db?.query("products");
    return List.generate(result!.length, (i) {
      return Product.fromObject(result[i]);
    }) ?? [];
  }

  Future<int?> insert(Product product) async {
    Database? db = await this.db;
    var result = await db?.insert("products", product.toMap());
    return result;
  }

  Future<int?> delete(int id) async {
    Database? db = await this.db;
    var result = await db?.rawDelete("DELETE FROM products WHERE id = ?", [id]);
    return result;
  }

  Future<int?> update(Product product) async {
    Database? db = await this.db;
    var result = await db?.update("products", product.toMap(), where: "id = ?", whereArgs: [product.id]);
    return result;
  }
}

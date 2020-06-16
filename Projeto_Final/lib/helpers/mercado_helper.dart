import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

final String carteiraTable = "carteiraTable";
final String idColumn = "idColumn";
final String siglaColumn = "siglaColumn";

class CarteiraHelper {

  static final CarteiraHelper _instance = CarteiraHelper.internal();

  factory CarteiraHelper() => _instance;

  CarteiraHelper.internal();

  Database _db;

  Future<Database> get db async {
    if(_db != null){
      return _db;
    } else {
      _db = await initDb();
      return _db;
    }
  }

  Future<Database> initDb() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, "carteirasnew.db");

    return await openDatabase(path, version: 1, onCreate: (Database db, int newerVersion) async {
      await db.execute(
        "CREATE TABLE $carteiraTable($idColumn INTEGER PRIMARY KEY, $siglaColumn TEXT)"
      );
    });
  }

  Future<Carteira> saveCarteira(Carteira carteira) async {
    Database dbCarteira = await db;
    carteira.id = await dbCarteira.insert(carteiraTable, carteira.toMap());
    return carteira;
  }

  Future<Carteira> getCarteira(int id) async {
    Database dbCarteira = await db;
    List<Map> maps = await dbCarteira.query(carteiraTable,
      columns: [idColumn, siglaColumn],
      where: "$idColumn = ?",
      whereArgs: [id]);
    if(maps.length > 0){
      return Carteira.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> deleteCarteira(int id) async {
    Database dbCarteira = await db;
    return await dbCarteira.delete(carteiraTable, where: "$idColumn = ?", whereArgs: [id]);
  }

  Future<int> updateCarteira(Carteira carteira) async {
    Database dbCarteira = await db;
    return await dbCarteira.update(carteiraTable,
        carteira.toMap(),
        where: "$idColumn = ?",
        whereArgs: [carteira.id]);
  }

  Future<List> getAllCarteiras() async {
    Database dbCarteira = await db;
    List listMap = await dbCarteira.rawQuery("SELECT * FROM $carteiraTable");
    List<Carteira> listCarteira = List();
    for(Map m in listMap){
      listCarteira.add(Carteira.fromMap(m));
    }
    return listCarteira;
  }

  Future<int> getNumber() async {
    Database dbCarteira = await db;
    return Sqflite.firstIntValue(await dbCarteira.rawQuery("SELECT COUNT(*) FROM $carteiraTable"));
  }

  Future close() async {
    Database dbCarteira = await db;
    dbCarteira.close();
  }

}

class Carteira {

  int id;
  String sigla;

  Carteira();

  Carteira.fromMap(Map map){
    id = map[idColumn];
    sigla = map[siglaColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      siglaColumn: sigla
    };
    if(id != null){
      map[idColumn] = id;
    }
    return map;
  }

  @override
  String toString() {
    return "Carteira(id: $id, sigla: $sigla)";
  }

}
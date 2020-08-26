import 'dart:async';
import 'package:uahep/database/database.dart';
import 'package:uahep/model/griv.dart';

class GrivDao {
  final dbProvider = DatabaseProvider.dbProvider;

  //Adds new Griv records
  Future<int> createGriv(Griv griv) async {
    final db = await dbProvider.database;
    var result = db.insert(grivTABLE, griv.toDatabaseJson());
    return result;
  }

  //Get All Griv items
  //Searches if query string was passed
  Future<List<Griv>> getGrivs({List<String> columns, String query}) async {
    final db = await dbProvider.database;

    List<Map<String, dynamic>> result;
    if (query != null) {
      if (query.isNotEmpty)
        result = await db.query(grivTABLE,
            columns: columns,
            where: 'description LIKE ?',
            whereArgs: ["%$query%"]);
    } else {
      result = await db.query(grivTABLE, columns: columns);
    }

    List<Griv> grivs = result.isNotEmpty
        ? result.map((item) => Griv.fromDatabaseJson(item)).toList()
        : [];
    return grivs;
  }

  //Update Griv record
  Future<int> updateGriv(Griv griv) async {
    final db = await dbProvider.database;

    var result = await db.update(grivTABLE, griv.toDatabaseJson(),
        where: "id = ?", whereArgs: [griv.id]);

    return result;
  }

  //Delete Griv records
  Future<int> deleteGriv(int id) async {
    final db = await dbProvider.database;
    var result = await db.delete(grivTABLE, where: 'id = ?', whereArgs: [id]);

    return result;
  }
}

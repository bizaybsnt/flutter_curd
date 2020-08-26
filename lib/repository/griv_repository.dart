import 'package:uahep/dao/griv_dao.dart';
import 'package:uahep/model/griv.dart';

class GrivRepository {
  final grivDao = GrivDao();

  Future getAllGrivs({String query}) => grivDao.getGrivs(query: query);

  Future insertGriv(Griv griv) => grivDao.createGriv(griv);

  Future updateGriv(Griv griv) => grivDao.updateGriv(griv);

  Future deleteGrivById(int id) => grivDao.deleteGriv(id);
}

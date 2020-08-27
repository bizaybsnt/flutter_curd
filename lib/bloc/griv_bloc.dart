import 'package:uahep/bloc/base_bloc.dart';
import 'package:uahep/model/griv.dart';
import 'package:uahep/repository/griv_repository.dart';

import 'dart:async';

class GrivBloc extends BaseBloc {
  final _grivRepository = GrivRepository();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _grivController = StreamController<List<Griv>>.broadcast();

  get grivs => _grivController.stream;

  GrivBloc() {
    getGrivs();
  }

  getGrivs({String query}) async {
    //sink is a way of adding data reactively to the stream
    //by registering a new event
    _grivController.sink.add(await _grivRepository.getAllGrivs(query: query));
  }

  addGriv(Griv griv) async {
    print('here');
    await _grivRepository.insertGriv(griv);
    getGrivs();
  }

  updateGriv(Griv griv) async {
    await _grivRepository.updateGriv(griv);
    getGrivs();
  }

  deleteGrivById(int id) async {
    _grivRepository.deleteGrivById(id);
    getGrivs();
  }

  @override
  void onDispose() {
    _grivController.close();
  }
}

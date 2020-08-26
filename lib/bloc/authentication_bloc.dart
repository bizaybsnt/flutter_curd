import 'dart:async';
import 'dart:convert';

import 'package:uahep/appconstants.dart';
import 'package:uahep/bloc/base_bloc.dart';

import 'package:uahep/model/user.dart';
import 'package:uahep/service/loginservice.dart';
import 'package:uahep/utils/dio_helper.dart';
import 'package:uahep/utils/error_helper.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationBloc extends BaseBloc {
  BehaviorSubject<bool> _isAuthenticated = BehaviorSubject.seeded(false);
  Stream<bool> get isAuthenticated => _isAuthenticated;
  User _user;
  User get user => _user;
  String _token;
  String get token => _token;

  BehaviorSubject<LoginState> _loginState =
      BehaviorSubject.seeded(LoginState.UNINITILIZED);
  Stream<LoginState> get loginState => _loginState;
  LoginService _loginService;

  AuthenticationBloc() {
    isUserAuthenticated();
    _loginService = LoginService();
  }

  isUserAuthenticated() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String userInfo = sharedPreferences.getString("user-info");
    _token = sharedPreferences.getString("token");
    print("shared token $token");
    if (userInfo == null) {
      _isAuthenticated.add(false);
      _user = null;
      return;
    }
    dio.options.headers['Authorization'] = 'Bearer $_token';
    print(userInfo);
    _user = User.fromJson(json.decode(userInfo));
    _isAuthenticated.add(true);
  }

  saveToken(token) async {
    dio.options.headers['Authorization'] = 'Bearer $token';
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(Preference.TOKEN, "$token");
  }

  saveUserInfo(User user) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.setString(
        Preference.USER_INFO, json.encode(user.toJson()));
  }

  loginUser(String email, String password) async {
    try {
      _loginState.add(LoginState.LOADING);
      var resposeData = await _loginService.loginuser(email, password);
      var token = resposeData["access_token"];
      await saveToken(token);
      _user = await _loginService.getUserInfo();
      await saveUserInfo(_user);
      isUserAuthenticated();
      _loginState.add(LoginState.ERROR);
    } catch (error) {
      _loginState.addError(ErrorHelper.getErrorMessage(error));
    }
  }

  fetchUserGrievance() async {}

  logout() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.remove(Preference.TOKEN);
    sharedPreferences.remove(Preference.USER_INFO);
    isUserAuthenticated();
    return true;
  }

  @override
  void onDispose() {
    _isAuthenticated.close();
    _loginState.close();
  }
}

enum LoginState {
  UNINITILIZED,
  LOADING,
  SUCCESS,
  ERROR,
}

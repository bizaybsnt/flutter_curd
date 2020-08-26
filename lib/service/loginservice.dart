import 'dart:async';

import 'package:uahep/model/user.dart';
import 'package:uahep/utils/dio_helper.dart';

import '../appconstants.dart';

class LoginService {
  Map<String, String> getHeaders() {
    return {"Content-Type": "application/json", "Accept": "application/json"};
  }

  Future<dynamic> loginuser(email, password) async {
    var requestData = {
      "mobile_number": email,
      "password": password,
    };
    var response = await dio.post(API.LOGIN, data: requestData);
    return response.data;
  }

  Future<User> getUserInfo() async {
    var response = await dio.post(API.USER_INFO);
    return User.fromJson(response.data['data']);
  }
}

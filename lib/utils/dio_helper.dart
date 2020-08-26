// import 'dart:io';

import 'package:dio/dio.dart';
import 'package:uahep/appconstants.dart';
import 'package:uahep/utils/error_helper.dart';

Dio dio = new Dio(BaseOptions(
    baseUrl: API.BASE_URL,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }))
  ..interceptors
      .add(InterceptorsWrapper(onRequest: (RequestOptions options) async {
    print(
        'interceptors ===  ${options.baseUrl} ===  ${options.path} ===  ${options.data} === ${options.headers}');
    return options;
  }, onResponse: (Response response) async {
    return ErrorHelper.extractResponse(response);
  }, onError: (DioError error) async {
    return ErrorHelper.extractApiError(error);
  }));

import 'dart:io';

import 'package:dio/dio.dart';

class ErrorHelper {
  static String getErrorMessage(error) {
    print('error helper === $error');
    if (error is DioError) {
      return error.message;
    }
    return error.toString();
  }

  static String extractApiError(DioError error) {
    print('error aayo  ==== ${error.error} === ${error.response}');
    String message = "Something went wrong";
    if (error is DioError) {
      if (error.error is SocketException) {
        message =
            "Cannot connect to server. Make sure you have proper internet connection";
        return message;
      }

      if (error.response != null && error.response.data['errors'] != null) {
        Map errorMessage = error.response.data['errors'];
        message = errorMessage.values.expand((i) => i).join("\n");
        print('error message ===== ${errorMessage.values}');
        return message;
      } else if (error.response != null &&
          error.response.data['message'] != null) {
        message = error.response.data['message'];
      } else if (error.message != null) {
        message = error.message;
      } else {
        message = error.message ?? error.response.statusMessage;
      }
    }
    return message;
  }

  static Response extractResponse(Response response){
  print("success zzz === ${response.data.runtimeType}");
    if (response.data is List) {
      return response;
    }
    Map<String, dynamic> data = response.data;
    print("reponse ===zzz ${data['status']} == ${data['status'] != null && data['status'] == false}==== $data");
    // if (data['status'] != null && data['status'] == false) {
    //   print('response false ');
    //   throw data['message'];
    // }
    if (data['synced_data'] != null && data['synced_data'] is Map && data['synced_data']['failed'] != null) {
      throw "The given data was invalid";
    }
    // print('success ==== ${data}');

    return response;
  }
}

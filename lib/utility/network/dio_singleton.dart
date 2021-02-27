



import 'package:dio/dio.dart';

import 'api_call.dart';

class DioSing {
  static final DioSing _singleton = new DioSing._internal();

  factory DioSing() {
    return _singleton;
  }

  DioSing._internal();

  static Future<Dio> getDio(
      {String baseUrl, ApiCallType apiCallType, Map<String,dynamic> customHeaders}) async {

    String url = "https://api.stackexchange.com/2.2/";

    String token = '';

    Map<String,dynamic> headers = <String, dynamic>{};


    switch (apiCallType) {

      case ApiCallType.SIMPLE:
        url = baseUrl ?? url;
        headers = <String, dynamic>{
          'Content-Type': 'application/json',
        };
        break;

      default:
        break;
    }

    if (customHeaders != null) {
      headers.addAll(customHeaders);
    }

    var dio = Dio(BaseOptions(
        baseUrl: baseUrl ?? url,
        connectTimeout: 50000,
        receiveTimeout: 50000,
        headers: headers));
    dio.interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
    return dio;
  }
}
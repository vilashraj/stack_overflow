import 'dart:convert';

import 'package:dio/dio.dart';

import 'api_call.dart';
import 'base_response.dart';
import 'dio_singleton.dart';
import 'net_call.dart';


class NetworkCallDio implements NetCall {
  Future<Dio> dio;

  NetworkCallDio(
      {String baseUrl,
      ApiCallType apicallType,
      Map<String, dynamic> customHeaders}) {
    dio = DioSing.getDio(
        baseUrl: baseUrl,
        apiCallType: apicallType,
        customHeaders: customHeaders);
  }

  @override
  Future delete(String path,
      {Function response,
      Function error,
      dynamic data,
      Map<String, dynamic> queryParameters}) async {
    try {
      var dio = await this.dio;
      var res =
          await dio.delete(path, data: data, queryParameters: queryParameters);
      return sendResponse(res, response);
    } catch (err) {
      if (error != null) {
        error(err);
      }
      return err;
    }
  }

  @override
  Future post(String path,
      {Function response,
        Function error,
        dynamic data,
        Map<String, dynamic> queryParameters,
        bool fullResponse}) async {
    try {
      var dio = await this.dio;
      var res =
      await dio.post(path, data: data, queryParameters: queryParameters);
      return sendResponse(res, response, fullResponse: fullResponse);
    } catch (err) {
      try {
        DioError dioError = err;
        return sendResponse(dioError.response, response,
            fullResponse: fullResponse);
      } catch (dError) {
        if (error != null) {
          error(err);
        }
        return Future.error(err);
      }
    }
  }

  sendResponse(res, Function response, {bool fullResponse = false}) {
    return res.data;
    // BaseResponse baseResponse;
    //
    // try {
    //   baseResponse = BaseResponse.fromJson(json.decode(res.data));
    // } catch (e) {
    //   try {
    //     baseResponse = BaseResponse.fromJson(res.data);
    //   } catch (e) {
    //     return Future.error(res.toString());
    //   }
    // }
    //
    // if (!fullResponse) {
    //   if (baseResponse.code == 0 ||
    //       baseResponse.code == 1 ||
    //       baseResponse.code == 10 ||
    //       baseResponse.code == 2 ||
    //       baseResponse.code == 3 ||
    //       baseResponse.code == '1') {
    //     if (response != null) {
    //       response(baseResponse.data);
    //     }
    //
    //     if (baseResponse.data == null) {
    //       return baseResponse.code;
    //     }
    //     return baseResponse.data;
    //   } else if (baseResponse.code == -3) {
    //
    //   } else {
    //     return Future.error(baseResponse.description);
    //   }
    // } else {
    //   return res.data;
    // }
  }

  @override
  Future put(String path,
      {Function response,
        Function error,
        dynamic data,
        Map<String, dynamic> queryParameters}) async {
    try {
      var dio = await this.dio;
      Response res =
      await dio.put(path, data: data, queryParameters: queryParameters);
      return sendResponse(res, response);
    } catch (err) {
      try {
        DioError dioError = err;
        return sendResponse(dioError.response, response);
      } catch (dError) {
        if (error != null) {
          error(err);
        }
        return Future.error(err);
      }
    }
  }

  @override
  Future get(String path,
      {Function response,
        Function error,
        Map<String, dynamic> queryParameters}) async {
    try {
      var dio = await this.dio;
      Response res = await dio.get(path, queryParameters: queryParameters);
      return sendResponse(res, response);
    } catch (err) {
      if (error != null) {
        error(err);
      }
      return err;
    }
  }

  @override
  Future postToken(String path,
      {Function response,
        Function error,
        data,
        Map<String, dynamic> queryParameters}) async {
    try {
      var dio = await this.dio;
      var res =
      await dio.post(path, data: data, queryParameters: queryParameters);
      return res.data;
    } catch (err) {
      try {
        DioError dioError = err;
        return sendResponse(dioError.response, response);
      } catch (dError) {
        if (error != null) {
          error(err);
        }
        return err;
      }
    }
  }

  @override
  Future getImage(String path,
      {Function response,
        Function error,
        Map<String, dynamic> queryParameters}) async {
    try {
      var dio = await this.dio;
      Response res = await dio.get(path, queryParameters: queryParameters);
      return res.data;
    } catch (err) {
      if (error != null) {
        error(err);
      }
      return err;
    }
  }
}

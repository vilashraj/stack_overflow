import 'package:flutter/material.dart';
import 'package:stack_overflow_vilash/utility/constants/string_constants.dart';

import '../connection_status.dart';
import 'generic_model.dart';
import 'net_call.dart';




enum RequestMethod { GET, PUT, POST, DELETE }

enum ApiCallType {SIMPLE }

class ApiCall {

  Future<dynamic> call<T>(
      {@required RequestMethod method,
        ApiCallType apiCallType,
        dynamic parameters,
        GenericModel obj,
        bool directResponse = false,
        String baseUrl,
        String endPoint,
        String apiPath,
        Map<String,dynamic> customHeaders,
        bool fullResponse = false}) async {
    List<T> list = [];

    var response;

    //Network connection Check

    bool connection = await ConnectionStatus().checkConnection();

    if (!connection) {

      throw(StringConstants.noInternetConnection);
    } else {
      //Create network call
      NetCall netCall =
      NetCall.create(baseUrl: baseUrl, apiCallType: apiCallType,customHeaders: customHeaders);

      //Api call as per request
      switch (method) {
        case RequestMethod.GET:
          response = await netCall.get(endPoint, queryParameters: parameters);
          break;
        case RequestMethod.POST:
          response = await netCall.post(endPoint, data: parameters,fullResponse: fullResponse);
          break;
        case RequestMethod.PUT:
          response = await netCall.put(endPoint,data: parameters);
          break;
        case RequestMethod.DELETE:
          break;
        default:
          break;
      }
    }

    //Set response as per user wants from specific given path from user
    var res = apiPath == null ? response : response[apiPath];

    //Check user wants for direct response
    if(fullResponse){
      return response;
    }
    else if (directResponse) {
      return res;
    }
    //Check response is Iterable if then return list otherwise return object of data model
    else if (res is Iterable) {
      if (res.isNotEmpty) {
        res.forEach((val) {
          list.add(obj.from(val));
        });
      }
      return list.toList();
    } else {
      return obj.from(res);
    }
  }
}
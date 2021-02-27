



import 'api_call.dart';
import 'network_call.dart';

abstract class NetCall {
  factory NetCall.create({String baseUrl, ApiCallType apiCallType,Map<String,dynamic> customHeaders}) {
    return NetworkCallDio(baseUrl: baseUrl, apicallType: apiCallType,customHeaders: customHeaders);
  }

  Future get(String path,
      {Function response,
        Function error,
        Map<String, dynamic> queryParameters});

  Future getImage(String path,
      {Function response,
        Function error,
        Map<String, dynamic> queryParameters});

  Future put(String path,
      {Function response,
        Function error,
        dynamic data,
        Map<String, dynamic> queryParameters});

  Future post(String path,
      {Function response,
        Function error,
        dynamic data,
        Map<String, dynamic> queryParameters,bool fullResponse});

  Future postToken(String path,
      {Function response,
        Function error,
        dynamic data,
        Map<String, dynamic> queryParameters});


  Future delete(String path,
      {Function response,
        Function error,
        dynamic data,
        Map<String, dynamic> queryParameters});
}
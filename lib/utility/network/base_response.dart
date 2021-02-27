

class BaseResponse {
  final dynamic code;
  final dynamic data;
  final String description;

  BaseResponse({this.code, this.data, this.description});

  factory BaseResponse.fromJson(Map<String, dynamic> json) {
    return BaseResponse(
        code: json['code'],
        data: json['data'],
        description: json['description']);
  }

  @override
  String toString() {
    return 'code: $code, data: $data, description : $description';
  }
}
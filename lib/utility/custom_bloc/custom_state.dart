import 'package:flutter/cupertino.dart';


abstract class CustomState {}

class CustomStateUninitialized extends CustomState {}

class CustomStateLoading extends CustomState {}

class CustomStateLoaded<T> extends CustomState {
  final T dataList;

  CustomStateLoaded({@required this.dataList});
}

class CustomStateError extends CustomState {
  final String errorText;

  CustomStateError({this.errorText});
}

class CustomStateSuccess<T> extends CustomState {
  final T data;

  CustomStateSuccess({this.data});
}



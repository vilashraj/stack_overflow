import 'package:flutter/material.dart';



abstract class CustomPaginationState {}

class CustomPaginationDataUninitialized extends CustomPaginationState {}

class CustomPaginationDataLoading extends CustomPaginationState {}

class CustomPaginationDataLoaded<T> extends CustomPaginationState {
  List<T> dataList;
  final bool hasReachedMax;

  CustomPaginationDataLoaded(
      {@required this.dataList, @required this.hasReachedMax});

  CustomPaginationDataLoaded copyWith({
    List<T> taskList,
    bool hasReachedMax,
  }) {
    return CustomPaginationDataLoaded(
      dataList: taskList ?? this.dataList,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}

class CustomPaginationDataError extends CustomPaginationState {
  final String errorText;

  CustomPaginationDataError(this.errorText);
}

class TaskDoneSuccess extends CustomPaginationState {}

class CustomPaginationDataEmpty extends CustomPaginationState {}

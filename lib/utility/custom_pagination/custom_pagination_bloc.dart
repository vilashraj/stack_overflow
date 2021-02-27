import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

import 'custom_pagination_event.dart';
import 'custom_pagination_repo.dart';
import 'custom_pagination_state.dart';




class CustomPaginationBloc
    extends Bloc<CustomPaginationEvent, CustomPaginationState> {
  CustomPaginationRepo customPaginationRepo;

  CustomPaginationBloc(CustomPaginationState initialState,
      {@required this.customPaginationRepo})
      : super(initialState);

  @override
  Stream<CustomPaginationState> mapEventToState(
      CustomPaginationEvent event) async* {
    if (event is FetchPaginationDataList && !hasReachedMax(state)) {
      try {
        if (state is CustomPaginationDataLoaded) {
          var data = await customPaginationRepo.fetchPaginationData(
              data: event.data,
              page:
                  (state as CustomPaginationDataLoaded).dataList.length ~/ 20 +
                      1,
              noOfRecords: 20);
          yield data.isEmpty
              ? (state as CustomPaginationDataLoaded)
                  .copyWith(hasReachedMax: true)
              : CustomPaginationDataLoaded(
                  dataList:
                      (state as CustomPaginationDataLoaded).dataList + data,
                  hasReachedMax: data.length < 20 ? true : false,
                );
        }

        if (state is CustomPaginationDataUninitialized ||
            state is CustomPaginationDataError) {
          yield CustomPaginationDataLoading();

          var data = await customPaginationRepo.fetchPaginationData(
              data: event.data, page: 1, noOfRecords: 20);

          if (data.length == 0) {
            yield CustomPaginationDataEmpty();
          } else {
            yield CustomPaginationDataLoaded(
                dataList: data, hasReachedMax: data.length < 20 ? true : false);
          }
        }
      } catch (e) {
        yield CustomPaginationDataError(e.toString());
      }
    }
  }

  bool hasReachedMax(CustomPaginationState state) =>
      state is CustomPaginationDataLoaded && state.hasReachedMax;
}

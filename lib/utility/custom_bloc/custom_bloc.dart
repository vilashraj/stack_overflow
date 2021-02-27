import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'custom_event.dart';
import 'custom_repo.dart';
import 'custom_state.dart';




class CustomBloc<T> extends Bloc<CustomEvent, CustomState> {
  CustomRepo customRepository;

  CustomBloc(CustomState initialState, {@required this.customRepository})
      : super(initialState);

  @override
  Stream<CustomState> mapEventToState(CustomEvent event) async* {
    try {
      if (event is FetchData) {
        yield CustomStateLoading();
        var data = await customRepository.fetchData(data: event.data);
        yield CustomStateLoaded(dataList: data);
      }
    } catch (e) {
      debugPrint('Error is ${e.toString()}');
      yield CustomStateError(errorText: e.toString());
    }


    if(event is RefreshData){
      try{
        var data = await customRepository.fetchData(data: event.data);
        yield CustomStateLoaded(dataList: data);
      }catch(e){
        yield CustomStateError(errorText: e.toString());
      }
    }
  }
}

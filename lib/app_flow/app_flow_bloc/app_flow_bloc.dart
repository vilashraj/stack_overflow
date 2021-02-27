import 'package:flutter_bloc/flutter_bloc.dart';

import 'app_flow_event.dart';
import 'app_flow_state.dart';



class AppFlowBloc extends Bloc<AppFlowEvent, AppFlowState> {
  AppFlowBloc(AppFlowState initialState) : super(initialState);

  @override
  Stream<AppFlowState> mapEventToState(AppFlowEvent event) async*{
    if(event is SplashEvent){
      yield SplashState();
    }

    else if(event is DashboardEvent){
      yield DashboardState();
    }


  }

}
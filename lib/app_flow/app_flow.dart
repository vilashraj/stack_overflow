
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_overflow_vilash/questions_list/ui/questions_list_ui.dart';
import 'package:stack_overflow_vilash/splash/splash_screen.dart';

import 'app_flow_bloc/app_flow_bloc.dart';
import 'app_flow_bloc/app_flow_state.dart';



class AppFlow extends StatefulWidget {
  @override
  _AppFlowState createState() => _AppFlowState();
}

class _AppFlowState extends State<AppFlow> {

  AppFlowBloc appFlowBloc;

  @override
  void initState() {

  appFlowBloc = AppFlowBloc(SplashState());
  super.initState();
  }
  @override
  void dispose() {
    appFlowBloc.close();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(),
    );
  }

  Widget getBody(){
    return BlocProvider(
      create: (context) => appFlowBloc,
      child: BlocBuilder(
        cubit: appFlowBloc,
        builder: (BuildContext context, AppFlowState state) {

          if(state is SplashState){
            return SplashScreen();
          }

          else if(state is DashboardState){
            return QuestionsListListUI();
          }

        return Container();
      },

      ),
    );
  }
}

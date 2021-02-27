import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stack_overflow_vilash/app_flow/app_flow_bloc/app_flow_bloc.dart';
import 'package:stack_overflow_vilash/app_flow/app_flow_bloc/app_flow_event.dart';
import 'package:stack_overflow_vilash/utility/constants/string_constants.dart';


class SplashScreen extends StatefulWidget {
  final Color backgroundColor = Colors.white;
  final TextStyle styleTextUnderTheLoader = TextStyle(
      fontSize: 18.0, fontWeight: FontWeight.bold, color: Colors.black);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final splashDelay = 5;
  AnimationController _controller;
  AnimationController _appNameController;
  Timer _timer ;
  AppFlowBloc appFlowBloc;
  @override
  void initState() {
    super.initState();
    appFlowBloc = BlocProvider.of<AppFlowBloc>(context);
    _controller = AnimationController(
        duration: const Duration(milliseconds: 2500), vsync: this);
    _appNameController = AnimationController(
        duration: const Duration(milliseconds: 500), vsync: this);

    _controller.forward();
    _appNameController.forward();
    // _controller.repeat(reverse: true, max: );
    _timer = new Timer(Duration(milliseconds: 2500), navigateFurther);
    // _checkLoginStatus();
  }

  navigateFurther() async {
    appFlowBloc.add(DashboardEvent());
  }

  @override
  void dispose() {
    this._controller.dispose();
    this._appNameController.dispose();
    this._timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          decoration: new BoxDecoration(
           color: Colors.white
          ),
          child: InkWell(
            child: Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      flex: 7,
                      child: Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              ScaleTransition(
                                  scale: Tween(begin: 0.5, end: 1.0).animate(
                                      CurvedAnimation(
                                          parent: _controller,
                                          curve: Curves.elasticOut,
                                          reverseCurve: Curves.elasticIn)),
                                  child: Image.asset(
                                    'assets/stack-overflow.png',
                                    height: 70,
                                    width: 70,
                                    colorBlendMode: BlendMode.dst,
                                  )),
                              SizedBox(width: 8.0,),
                              FadeTransition(
                                  opacity: _appNameController,
                                  child: Text(
                                    StringConstants.appName,
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                  )),
                            ],
                          )),
                    ),
                    Expanded(
                      child: Column(
                        children: <Widget>[

                          Container(
                            height: 10,
                          ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Text(
                                  "v1.0.0",
                                  style: TextStyle(color: Colors.black),
                                ),
                              ])
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}

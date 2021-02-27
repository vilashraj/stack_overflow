import 'dart:io';

import 'package:flutter/material.dart';
import 'package:stack_overflow_vilash/utility/base/emtpy_screen.dart';
import 'package:stack_overflow_vilash/utility/custom_bloc/custom_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';

class QuestionDetail extends StatefulWidget {
  final String url;
  QuestionDetail({@required this.url});
  @override
  _QuestionDetailState createState() => _QuestionDetailState();
}

class _QuestionDetailState extends State<QuestionDetail> {

  //variables:
  int stackIndex = 0;

  //controllers:
  WebViewController _controller;

  //flags:
  bool enableBack = false;



  @override
  void initState() {



    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: enableBack?()async{

        bool canGoBack = await _controller.canGoBack();

        if(canGoBack == true){
          await _controller.goBack();
        }
        setState(() {
          enableBack = false;
        });
        return false;

      }:()async{
        return true;
      },
      child: Scaffold(
        appBar: AppBar(),
        body:questionDetailView(widget.url),

    ),
    );
  }

  Widget questionDetailView(String url){
    return IndexedStack(
      index: stackIndex,
      children: <Widget>[
        getLoader(),
        getWebView(url),
        getErrorWidget("Failed to load the question details")
      ],
    );
  }
  Widget getWebView(String url){
    return WebView(

      onWebViewCreated: (WebViewController webViewController)async{
        _controller = webViewController;
        _controller.loadUrl(url);
      },
      onWebResourceError: (error){
        setState(() {
          stackIndex = 2;
        });
      },
      navigationDelegate: (NavigationRequest request)async{
        bool canGoBack = await _controller.canGoBack();

        if(canGoBack){
          setState(() {
            enableBack = true;
          });
        }
        return NavigationDecision.navigate;
      },
      onPageStarted: (val){
        setState(() {
          stackIndex = 0;
        });
      },
      onPageFinished: (val){
        setState(() {
          stackIndex = 1;
        });
      },
    );
  }
  Widget getLoader(){
    return Center(child: CircularProgressIndicator());
  }

  Widget getErrorWidget(String title){
    return EmptyScreen.error(title: title, onClick: (){

      _controller.loadUrl(widget.url);
    });
  }
}

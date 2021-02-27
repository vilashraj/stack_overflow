import 'package:flutter/material.dart';

import 'app_flow/app_flow.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Stack Overflow',
      theme: ThemeData(
          primaryColor: Colors.blue[900],
          scaffoldBackgroundColor: Colors.white,

          brightness: Brightness.light,
          accentColor: Colors.blue,
          primarySwatch: Colors.blue
      ),
      home: AppFlow(),
    );
  }
}



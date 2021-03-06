import 'package:flutter/material.dart';

class BaseCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(Theme.of(context).accentColor),

      ),
    );
  }
}

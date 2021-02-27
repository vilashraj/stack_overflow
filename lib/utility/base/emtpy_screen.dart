import 'package:flutter/material.dart';

import 'base_button.dart';

// ignore: must_be_immutable
class EmptyScreen extends StatefulWidget {
  IconData icon;
  String title;
  Function onClick;


  EmptyScreen({@required  this.icon, @required this.title});

  EmptyScreen.error({@required this.title,@required this.onClick});


  @override
  _EmptyScreenState createState() => _EmptyScreenState();
}

class _EmptyScreenState extends State<EmptyScreen> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          return Center(
            child:widget.onClick==null?Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(widget.icon, size: constraints.maxWidth * 0.2, color: Colors.grey),
                ),
                Text(widget.title,textAlign: TextAlign.center,)
              ],
            ):Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.title,textAlign: TextAlign.center,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: BaseButton.icon(Icon(Icons.refresh), onTap: widget.onClick,),
                )
              ],
            ),
          );
        }
    );
  }
}
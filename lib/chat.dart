import 'package:flutter/material.dart';

const String _name = "Esa";

class ChatMessage extends StatelessWidget {
  ChatMessage({this.text, this.animationController});

  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context) {
    final avatar = new Container(
      margin: const EdgeInsets.only(right: 16.0),
      child: new CircleAvatar(child: new Text(_name[0])),
    );

    final message = new Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        new Text(_name, style: Theme.of(context).textTheme.subhead),
        new Container(
          margin: const EdgeInsets.only(top: 5.0),
          child: new Text(text),
        )
      ],
    );

    final container = new Container(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      child: new Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[avatar, message],
      ),
    );

    return new SizeTransition(
      sizeFactor: new CurvedAnimation(
          parent: animationController, curve: Curves.bounceOut),
      axisAlignment: 0.0,
      child: container,
    );
  }
}

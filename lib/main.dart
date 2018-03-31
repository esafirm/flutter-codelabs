import 'package:flutter/material.dart';

import 'chat.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Demo - Change Text',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new ChatScreen(),
    );
  }
}

class ChatScreenState extends State<ChatScreen> with TickerProviderStateMixin {
  final List<ChatMessage> _messages = <ChatMessage>[];
  final TextEditingController _textController = new TextEditingController();

  bool _isComposing = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: new Text("Chat Screen")),
      body: new Column(
        children: <Widget>[_buildList(), _buildInput()],
      ),
    );
  }

  _handleSubmit(String text) {
    print("Handle Submit here..." + text);
    _textController.clear();

    final message = new ChatMessage(
        text: text,
        animationController: new AnimationController(
            vsync: this, duration: new Duration(milliseconds: 700)));

    setState(() {
      _messages.add(message);
    });

    message.animationController.forward();
  }

  Widget _buildList() {
    final listView = new ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemBuilder: (_, int index) => _messages[index],
      itemCount: _messages.length,
      reverse: true,
    );

    return new Flexible(child: listView);
  }

  Widget _buildInput() {
    final textField = new Flexible(
      child: new Padding(
        padding: new EdgeInsets.symmetric(horizontal: 8.0),
        child: new TextField(
          controller: _textController,
          onSubmitted: (text) => _handleSubmit(text),
          decoration: new InputDecoration.collapsed(hintText: "Send a message"),
          onChanged: (text) => setState(() => _isComposing = text.length > 0),
        ),
      ),
    );

    return new Container(
      margin: new EdgeInsets.symmetric(vertical: 0.8),
      child: new Row(
        children: <Widget>[
          textField,
          new Opacity(
            opacity: _isComposing ? 1.0 : 0.5,
            child: new IconButton(
              icon: new Icon(Icons.send),
              onPressed: () =>
                  _isComposing ? _handleSubmit(_textController.text) : null,
            ),
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    for (ChatMessage message in _messages)
      message.animationController.dispose();
    super.dispose();
  }
}

class ChatScreen extends StatefulWidget {
  @override
  State createState() => new ChatScreenState();
}

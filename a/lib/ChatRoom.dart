import 'package:flutter/material.dart';

class ChatRoom extends StatelessWidget {
  final String name;

  const ChatRoom({Key? key, required this.name}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(name),
        ));
  }
}

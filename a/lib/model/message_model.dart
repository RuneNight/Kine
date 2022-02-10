import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Message {
  Message(this.uid, this.message, this.createdAt, this.id);
  String uid;
  String message;
  Timestamp createdAt;
  String id;
}

class MessageModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  List<Message>? messagelist;
  void fetchMessage(name) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('chat_room')
        .doc()
        .collection('MessageList')
        .orderBy("createdAt", descending: false)
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      final List<Message> messagelist =
          snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        final String uid = data['uid'];
        final String message = data['message'];
        final Timestamp createdAt = data['createdAt'];
        final String id = data['id'];
        return Message(uid, message, createdAt, id);
      }).toList();
      this.messagelist!.clear();
      this.messagelist = messagelist;
      // for (var i = 0; i < messagelist.length; i++) {
      //   _addMessage(types.TextMessage(
      //     author: types.User(id: messagelist[i].uid),
      //     createdAt: messagelist[i].createdAt.millisecondsSinceEpoch,
      //     id: messagelist[i].id,
      //     text: messagelist[i].message,
      //   ));
      // }
    });
  }
}

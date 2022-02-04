import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RoomList {
  RoomList(this.name, this.createdAt);
  String name;
  Timestamp createdAt;
}
class RoomListModel extends ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  List<RoomList>? list;

  void fetchRoom() {
    _firestore
        .collection("chat_room")
        .snapshots()
        .listen((QuerySnapshot snapshot) {
      final List<RoomList> room =
      snapshot.docs.map((DocumentSnapshot document) {
        Map<String, dynamic> data = document.data() as Map<String, dynamic>;
        final String name = data["name"];
        final Timestamp createdAt = data["createdAt"];
        return RoomList(name, createdAt);
      }).toList();
      list = room;
      notifyListeners();
    });
  }
}

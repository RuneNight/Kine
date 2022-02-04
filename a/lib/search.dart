import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:a/ChatRoom.dart';
import 'package:a/builds/textfield.dart';

class SearchPage extends StatelessWidget {
  String room = '';
  List<DocumentSnapshot> documentList = [];
  TextEditingController roomNameController = TextEditingController();

  SearchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SearchPage"),
      ),
      body: SizedBox(
          width: double.infinity,
          child: Column(children: [
            buildTextFormField('RoomName', roomNameController),
            TextButton(
              onPressed: () async {
                FirebaseFirestore.instance
                    .collection('chat_room')
                    .where('name', isEqualTo: roomNameController.text)
                    .get()
                    .then((QuerySnapshot querySnapshot) {
                  for (var doc in querySnapshot.docs) {
                    final name = doc["name"];
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(name),
                            content: TextButton(
                              child: const Text("ルームへ"),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChatPage(
                                            name:name
                                        ),
                                  ),
                                );
                              },
                            ),
                          );
                        });
                  }
                });
              },
              child: Text(
                'Search',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Theme
                      .of(context)
                      .primaryColor,
                ),
              ),
            ),
          ])),
    );
  }
}

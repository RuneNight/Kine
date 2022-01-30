import 'package:a/builds/textfield.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
          child: Column(
              children: [
                buildTextFormField('RoomName', roomNameController),
                TextButton(onPressed: () async {
                  FirebaseFirestore.instance
                      .collection('chat_room')
                      .where('name',isEqualTo: roomNameController.text)
                      .get()
                      .then((QuerySnapshot querySnapshot) {
                    querySnapshot.docs.forEach((doc) {
                      final name = doc["name"];
                      print(name);
                    });
                  });
                },
                  child: Text('Search',
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

import 'package:a/builds/textfield.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchPage extends StatelessWidget {


  String room = '';
  List<DocumentSnapshot> documentList = [];

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
              buildTextFormField('RoomName',room),
                TextButton(onPressed: () async {
                  final _store = FirebaseFirestore.instance;
                  _store.collection('chat_room').where('name', isEqualTo: room).get();
                },
                  child: Text('Search',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                  ),
                  ),
                )
             ],
          ),
      ),
    );
  }
}

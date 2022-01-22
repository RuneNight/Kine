
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
          TextFormField(
          decoration: const InputDecoration(labelText: "RoomName"),
          onChanged: (text){
            if (text.isNotEmpty){
              room = text;
            }
          }
      ),
                TextButton(onPressed: () async {
                  final _store = FirebaseFirestore.instance;
                  _store.collection('chat_room').where('name', isEqualTo: room).get();
                },
                  child: Text('Search',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Theme.of(context).primaryColor,
                  ),),

                )
        ],
          ),
      ),
    );
  }
}

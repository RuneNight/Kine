import 'package:a/builds/padding.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'home.dart';

class RoomAdd extends StatelessWidget {
  const RoomAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'sss',
      home: RoomScrren(),
    );
  }
}

class RoomScrren extends StatelessWidget{

  String roomname = "";
  String uid = FirebaseAuth.instance.currentUser!.uid;

  RoomScrren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: .6,
        actions: [
          TextButton(
            onPressed: () async {
            final date = DateTime.now().toLocal().toIso8601String();
            await FirebaseFirestore.instance
                .collection('chat_room')
                .doc(roomname)
                .set({
              'name': roomname,
              'adminuid': uid,
              'createdAt': date,
            });
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HomePage(),
                  fullscreenDialog: true,
                ),
              );

            },
            child: Text('Create',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Theme.of(context).primaryColor,
            ),),
          ),
        ],
        title: const Text("Room Create",
          style: TextStyle(
            color: Colors.black87,
        ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            buildPadding(),
            InkWell( onTap: (){

            },
             child: Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
             ),
            ),
        TextFormField(
            maxLengthEnforcement: MaxLengthEnforcement.none,
            maxLength: 20,
            decoration: const InputDecoration(labelText: 'RoomName'),
            onChanged: (text){
              if (text.isNotEmpty){
                roomname = text;
              }
            }
        )
          ],
      ),
    ),
    );
  }
}
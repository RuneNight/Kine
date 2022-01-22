import 'package:cloud_firestore/cloud_firestore.dart';
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
            const Padding(padding: EdgeInsets.all(10),),
            InkWell( onTap: (){

            },
             child: Container(
              width: 150,
              height: 150,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
             ),
            ),
              IconButton(
                icon: const Icon(Icons.camera_alt),
                onPressed: () {

                },
              ),
          SingleChildScrollView(
            child: TextFormField(
                maxLengthEnforcement: MaxLengthEnforcement.none,
                maxLength: 20,
                decoration: const InputDecoration(labelText: "RoomName"),
                onChanged: (text){
                  if (text.isNotEmpty){
                    roomname = text;
                  }
                }
            ),
      ),
          ],
      ),
    ),
    );
  }
}
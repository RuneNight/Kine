import 'package:a/builds/padding.dart';
import 'package:a/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class roomSettingPage extends StatelessWidget {
  static String? roomname;
  static String? editName;
  static String dropdownValue = 'One';
  final String docid;

  const roomSettingPage(
      {Key? key, required String roomname, required String this.docid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("SettingPage"),
          backgroundColor: Colors.deepPurple,
        ),
        body: Scrollbar(
            child: SingleChildScrollView(
                child: Container(
          child: Column(
            children: [
              buildPadding(10),
              const Text(
                'RoomName',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.green,
                ),
              ),
              TextFormField(
                  maxLengthEnforcement: MaxLengthEnforcement.none,
                  maxLength: 20,
                  decoration: const InputDecoration(labelText: 'RoomName'),
                  onChanged: (text) {
                    if (text.isNotEmpty) {
                      editName = text;
                    }
                  }),
              Icon(
                Icons.color_lens,
                color: Colors.red,
                size: 40,
              ),
              Text(
                'RoomColor',
                style: TextStyle(
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                  color: Colors.red,
                ),
              ),
              buildPadding(5),
              SizedBox(
                  width: 350,
                  height: 100,
                  child: ElevatedButton(
                    child: Text(
                      'Save',
                      style: TextStyle(fontSize: 70, color: Colors.black87),
                    ),
                    style: ElevatedButton.styleFrom(
                      onPrimary: Colors.green,
                      primary: Colors.black12,
                      shape: const StadiumBorder(),
                    ),
                    onPressed: () async {
                      final doc = FirebaseFirestore.instance
                          .collection('chat_room')
                          .doc(docid);
                      doc.update({
                        'name': editName,
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                          fullscreenDialog: true,
                        ),
                      );
                    },
                  )),
              buildPadding(30),
            ],
          ),
        ))));
  }
}

import 'package:a/builds/padding.dart';
import 'package:a/builds/textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController nicknameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();

  String get uid => FirebaseAuth.instance.currentUser!.uid;

  @override
  Widget build(BuildContext context) {
    AppBar(
      title: const Text("Settings_Page"),
    );
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            buildPadding(5),
            const Text(
              'Profile',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
            buildPadding(5),
            buildTextFormField('NickName', nicknameController),
            buildPadding(10),
            buildTextFormField('Birthday', birthdayController),
            buildPadding(5),
            SizedBox(
                width: 200,
                height: 80,
                child: ElevatedButton(
                    child: const Text('Save'),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blueGrey,
                    ),
                    onPressed: () async {
                      //databaseに保存
                      final doc = FirebaseFirestore.instance.collection('users')
                          .doc(uid);
                      doc.update({
                        'nickname': nicknameController.text,
                        'birthday': birthdayController.text,
                      });
                    }
                )
            ),
            
          ]
      ),
    );
  }
}

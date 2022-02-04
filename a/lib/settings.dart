import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:a/builds/padding.dart';
import 'package:a/builds/textfield.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextEditingController nicknameController = TextEditingController();
  TextEditingController birthdayController = TextEditingController();

  String get uid => FirebaseAuth.instance.currentUser!.uid;

  DateTime _date = new DateTime.now();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _date,
        firstDate: new DateTime(1900),
        lastDate: new DateTime.now());
    if (picked != null) setState(() => _date = picked);
  }

  @override
  Widget build(BuildContext context) {
    AppBar(
      title: const Text("Settings_Page"),
    );
    return SingleChildScrollView(
      child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
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
        Center(child: Text("${_date}")),
        SizedBox(
          width: 300,
          height: 80,
          child: ElevatedButton(
            onPressed: () => _selectDate(context),
            child: const Text('Birthday',
              style: TextStyle(
                color: Colors.pinkAccent,
                fontSize: 30,
              ),
            ),
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
            ),
          ),
        ),
        buildPadding(15),
        SizedBox(
            width: 400,
            height: 100,
            child: ElevatedButton(
                child: const Text('Save'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                ),
                onPressed: () async {
                  final doc =
                  FirebaseFirestore.instance.collection('users').doc(uid);
                  doc.update({
                    'nickname': nicknameController.text,
                    'birthday': _date,
                  });
                })),
      ]),
    );
  }
}

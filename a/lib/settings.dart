import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingsPage extends StatefulWidget {


  static String get email => FirebaseAuth.instance.currentUser?.email as String;

  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  String nickname = '';

  String password = '';

  @override
  Widget build(BuildContext context) {
    AppBar(
      title: const Text("Settings_Page"),
    );
    return SingleChildScrollView(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
              ),
              const Text(
                'Profile',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(5),
              ),
      TextFormField(
        decoration: const InputDecoration(labelText: "NickName"),
        onChanged: (text) {
          if (text.isNotEmpty){
            final nickname = text;
          }
        },
      ),
              const Padding(
                padding: EdgeInsets.all(5),
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: "BirthDay"),
                onChanged: (text) {
                  if (text.isNotEmpty){
                    final birthday = text;
                  }
                },
              ),
              const Padding(
                padding: EdgeInsets.all(5),
              ),
        TextFormField(
          decoration: const InputDecoration(labelText: "Password"),
          onChanged: (text) {
            if (text.isNotEmpty){
              final String? password = text;
            }
          },
        ),
              const Padding(
                padding: EdgeInsets.all(15),
              ),
        SizedBox(
      width:  200,
      height: 80,
      child:  ElevatedButton(
      child: const Text('Save'),
      style: ElevatedButton.styleFrom(
      primary: Colors.blueGrey,
      ),
      onPressed: () async {
          }
          )
    )
        ]
        ),
  );
  }
}

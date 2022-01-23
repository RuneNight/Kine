import 'package:a/builds/padding.dart';
import 'package:a/builds/textfield.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:a/login.dart';

class RegistrationPage extends StatelessWidget {

  String email ='';
  String password ='';



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration_Page"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            buildTextFormField('EmailAddress',email),
            buildPadding(),
            buildTextFormFieldPassword('Password',password),
            SizedBox(
              width:  200,
              height: 50,
              child:  ElevatedButton(child: const Text('Enter'),
                  onPressed: () async {
                    final userCredential = await FirebaseAuth.instance
                        .createUserWithEmailAndPassword(
                        email: email, password: password);
                    final user = userCredential.user;
                    if (user != null) {
                      final uid = user.uid;
                      final doc = FirebaseFirestore.instance.collection(
                          'users').doc(uid);
                      await doc.set({
                        'uid': uid,
                        'email': email,
                      });
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginPage(),
                          fullscreenDialog: true,
                        ),
                      );
                    }
                  }),
            ),
              ]
        ),
      ),
    );
  }
}

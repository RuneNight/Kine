import 'package:a/builds/padding.dart';
import 'package:a/builds/textfield.dart';
import 'package:a/pages/login.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegistrationPage extends StatelessWidget {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Registration_Page"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(children: [
          buildTextFormField('EmailAddress', emailController),
          buildPadding(5),
          buildTextFormFieldPassword('Password', passwordController),
          SizedBox(
            width: 200,
            height: 50,
            child: ElevatedButton(
                child: const Text('Enter'),
                onPressed: () async {
                  final userCredential = await FirebaseAuth.instance
                      .createUserWithEmailAndPassword(
                          email: emailController.text,
                          password: passwordController.text);
                  final user = userCredential.user;
                  if (user != null) {
                    final uid = user.uid;
                    final doc =
                        FirebaseFirestore.instance.collection('users').doc(uid);
                    await doc.set({
                      'uid': uid,
                      'email': emailController.text,
                    });
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginPage(),
                      ),
                    );
                  }
                }),
          ),
        ]),
      ),
    );
  }
}

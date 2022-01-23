import 'package:a/home.dart';
import 'package:a/builds/padding.dart';
import 'package:a/builds/textfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {

  String login_email = '';
  String login_password = '';

  LoginPage({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login_Page"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            buildTextFormField('EmailAddress',login_email),
            buildPadding(),
            buildTextFormFieldPassword('Password',login_password),
            buildPadding(),
            SizedBox(
              width:  200,
              height: 50,
              child:  ElevatedButton(
                  child: const Text('Login'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                ),
                  onPressed: () {
                    FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: login_email, password: login_password);
                    if (FirebaseAuth.instance.currentUser != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomePage(),
                          fullscreenDialog: true,
                        ),
                      );
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
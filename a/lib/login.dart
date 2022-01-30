import 'package:a/home.dart';
import 'package:a/builds/padding.dart';
import 'package:a/builds/textfield.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatelessWidget {

  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();

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
            buildTextFormField('EmailAddress', loginEmailController),
            buildPadding(5),
            buildTextFormFieldPassword('Password', loginPasswordController),
            buildPadding(5),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                  child: const Text('Login'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                  ),
                  onPressed: () {
                    //firebaselogin
                    FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: loginEmailController.text,
                        password: loginPasswordController.text);
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
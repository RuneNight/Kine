import 'package:a/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';

class LoginPage extends StatelessWidget {

  String login_email = "";
  String login_password = "";

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
            TextFormField(
              decoration: const InputDecoration(labelText: "MailAddress"),
              onChanged: (text) {
                if (text.isNotEmpty){
                  login_email = text;
                }
              },
            ),
            const Padding(
              padding: EdgeInsets.all(10),
            ),
            TextFormField(
              obscureText: true,
                maxLengthEnforcement: MaxLengthEnforcement.none,
                maxLength: 20,
              decoration: const InputDecoration(labelText: "Password"),
                onChanged: (text){
                  if (text.isNotEmpty){
                    login_password = text;
                  }
                }
            ),
            const Padding(
              padding: EdgeInsets.all(10),
            ),
            SizedBox(
              width:  200,
              height: 50,
              child:  ElevatedButton(
                  child: const Text('Login'),
                style: ElevatedButton.styleFrom(
                    primary: Colors.green,
                ),
                  onPressed: () {
                    //null check
                    FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: login_email, password: login_password);

                    if (FirebaseAuth.instance.currentUser != null) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const HomePage(),
                            fullscreenDialog: true,
                  ),
                      );
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
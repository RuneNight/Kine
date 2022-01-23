import 'package:a/login.dart';
import 'package:a/builds/padding.dart';
import 'package:a/registration.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:a/home.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        title: 'AccountPage',
        debugShowCheckedModeBanner: false,
        home: Registration());
  }
}

class Registration extends StatelessWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width:  1000,
                  height: 200,
          child: ElevatedButton(child: Text('Registration',
              style: GoogleFonts.sawarabiMincho(
                  textStyle: Theme.of(context).textTheme.headline4,
                  color: Colors.redAccent,
                  fontSize: 60.0,
          )),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => RegistrationPage(),
                    )
                );
              }),
                ),
                buildPadding(),
          SizedBox(
            width:  1000,
            height: 200,
              child:  ElevatedButton(child: Text('Login',
                style: GoogleFonts.sawarabiMincho(
                textStyle: Theme.of(context).textTheme.headline4,
                color: Colors.redAccent,
                fontSize: 60.0,
              )),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage(),
                    )
                );
                    if (FirebaseAuth.instance.currentUser != null) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const HomePage(),
                        fullscreenDialog: true,
                      )
                    );
                   }
                })
               ),
            ],
        ),
      ),
    );
  }
}



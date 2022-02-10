import 'package:a/pages/home.dart';
import 'package:a/pages/login.dart';
import 'package:a/pages/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'builds/padding.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _auth = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AccountPage',
      debugShowCheckedModeBanner: false,
      home: _auth != null ? const HomePage() : const Registration(),
      darkTheme: ThemeData.dark(),
    );
  }
}

class Registration extends StatelessWidget {
  const Registration({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account_Page"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            buildPadding(21.0),
            SizedBox(
              width: 1000,
              height: 200,
              child: ElevatedButton(
                  child: Text(
                    'Registration',
                    style: GoogleFonts.sawarabiMincho(
                      textStyle: Theme.of(context).textTheme.headline4,
                      color: Colors.redAccent,
                      fontSize: 60.0,
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegistrationPage(),
                      ),
                    );
                  }),
            ),
            buildPadding(10),
            SizedBox(
                width: 1000,
                height: 200,
                child: ElevatedButton(
                    child: Text(
                      'Login',
                      style: GoogleFonts.sawarabiMincho(
                        textStyle: Theme.of(context).textTheme.headline4,
                        color: Colors.redAccent,
                        fontSize: 60.0,
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                    })),
          ],
        ),
      ),
    );
  }
}

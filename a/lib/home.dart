import 'package:a/room.dart';
import 'package:flutter/material.dart';
import 'package:a/settings.dart';
import 'package:a/chat.dart';



class HomePage extends StatelessWidget {

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),

    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key,}) : super(key: key);


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _selectIndex = 0;
  final _pages = [
     chat(),
     const SettingsPage(),
  ];



  void _onTapItem(int index) {
    setState(() {
      _selectIndex = index;
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.green,
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(builder: (context) =>  const RoomAdd())
            );
          },
          child: const Icon(Icons.person),
        ),
        body: _pages[_selectIndex],
    bottomNavigationBar: BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Icon(Icons.home),
        label: 'Home',
    ),
      BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings',
    ),
    ],
      currentIndex: _selectIndex,
      onTap: _onTapItem,
              )
    );
  }
}

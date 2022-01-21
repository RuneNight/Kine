import 'package:flutter/material.dart';

class chat extends StatelessWidget {




  var namelist = ['test1', 'test2', 'test3'];
  var sublist = ['a', 'b', 'c'];

  chat({Key? key}) : super(key: key);




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 8,
        title: const Text(
          'Meessages',
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.search),
              color: Colors.black87,
            onPressed: () {
            }
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          children: [
            for (var i = 0; i < namelist.length; i++)
            ListTile(
              onTap: (){
              },
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20.0,
                vertical: 8.0,
              ),
            leading: const CircleAvatar(),
              trailing: const Text(""),
              title: Text(namelist[i]),
              subtitle: Text(sublist[i]),
            ),
          ]
        ),
      )
    );
  }
}
import 'package:flutter/material.dart';

class RoomAdd extends StatelessWidget {
  const RoomAdd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'sss',
      home: RoomScrren(),
    );
  }
}

class RoomScrren extends StatelessWidget{
  const RoomScrren({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: .6,
        title: const Text("Room Create",
          style: TextStyle(
            color: Colors.black87,
        ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(30),),
            InkWell( onTap: (){

            },
             child: Container(
              width: 300,
              height: 300,
              decoration: const BoxDecoration(
                color: Colors.blue,
                shape: BoxShape.circle,
              ),
             ),
            ),
              IconButton(
                icon: const Icon(Icons.camera_alt),
                onPressed: () {

                },

              ),
          ],
      ),
    ),
    );
  }
}
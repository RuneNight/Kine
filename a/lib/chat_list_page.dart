import 'package:flutter/material.dart';
import 'package:a/ChatRoom.dart';
import 'package:a/model/room_list_model.dart';
import 'package:a/search.dart';
import 'package:provider/provider.dart';

class Chat extends StatefulWidget {
  const Chat({Key? key}) : super(key: key);

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RoomListModel>(
        create: (_) =>
        RoomListModel()
          ..fetchRoom(),
        child: Scaffold(
          appBar: AppBar(
            elevation: 8,
            title: const Text(
              'Messages',
            ),
            actions: [
              IconButton(
                  icon: const Icon(Icons.search),
                  color: Colors.black87,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SearchPage(),
                        fullscreenDialog: true,
                      ),
                    );
                  }),
            ],
          ),
          body: Consumer<RoomListModel>(
            builder: (context, model, child) {
              final List<RoomList>? room = model.list;
              if (room == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              final List<Widget> widgets = room.map((data) {
                return ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ChatPage(
                                  name: data.name
                              ),
                        ),
                      );
                    },
                    title: Text(data.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),)
                );
              }).toList();

              return Column(
                children: widgets,
              );
            },
          ),
        ));
  }
}

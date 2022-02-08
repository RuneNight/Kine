import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:open_file/open_file.dart';
import 'package:uuid/uuid.dart';

class Message {
  Message(this.uid, this.message, this.createdAt, this.id);
  String uid;
  String message;
  Timestamp createdAt;
  String id;
}

class ChatPage extends StatefulWidget {
  final String name;
  const ChatPage({Key? key, required this.name}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final List<types.Message> _messages = [];
  final _auth = FirebaseAuth.instance.currentUser!.uid;
  var _user;
  List<Message>? messagelist;
  @override
  void initState() {
    super.initState();
    _user = types.User(id: _auth);
    _loadMessages();
  }

  void _addMessage(types.Message message) {
    setState(() {
      _messages.insert(0, message);
    });
  }

  void _handleAtachmentPressed() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: SizedBox(
            height: 144,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleImageSelection();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Photo'),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    _handleFileSelection();
                  },
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('File'),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Cancel'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleFileSelection() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.any,
    );

    if (result != null && result.files.single.path != null) {
      final message = types.FileMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        id: const Uuid().v4(),
        mimeType: lookupMimeType(result.files.single.path!),
        name: result.files.single.name,
        size: result.files.single.size,
        uri: result.files.single.path!,
      );

      _addMessage(message);
    }
  }

  void _handleImageSelection() async {
    final result = await ImagePicker().pickImage(
      imageQuality: 70,
      maxWidth: 1440,
      source: ImageSource.gallery,
    );

    if (result != null) {
      final bytes = await result.readAsBytes();
      final image = await decodeImageFromList(bytes);

      final message = types.ImageMessage(
        author: _user,
        createdAt: DateTime.now().millisecondsSinceEpoch,
        height: image.height.toDouble(),
        id: const Uuid().v4(),
        name: result.name,
        size: bytes.length,
        uri: result.path,
        width: image.width.toDouble(),
      );
      _addMessage(message);
    }
  }

  void _handleMessageTap(BuildContext context, types.Message message) async {
    if (message is types.FileMessage) {
      await OpenFile.open(message.uri);
    }
  }

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = _messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = _messages[index].copyWith(previewData: previewData);

    WidgetsBinding.instance?.addPostFrameCallback((_) {
      setState(() {
        _messages[index] = updatedMessage;
      });
    });
  }

  void _handleSendPressed(types.PartialText message) async {
    final textMessage = types.TextMessage(
      author: _user,
      createdAt: DateTime.now().millisecondsSinceEpoch,
      id: const Uuid().v4(),
      text: message.text,
    );
    _addMessage(textMessage);
    final doc = FirebaseFirestore.instance
        .collection('chat_room')
        .doc(widget.name)
        .collection('MessageList');
    doc.add({
      'message': message.text,
      'uid': _auth,
      'createdAt': Timestamp.now(),
      'id': const Uuid().v4(),
    });
  }

  void _loadMessages() async {
    final QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('chat_room')
        .doc(widget.name)
        .collection('MessageList')
        .orderBy("createdAt", descending: false)
        .get();
    final List<Message> messagelist =
        snapshot.docs.map((DocumentSnapshot document) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final String uid = data['uid'];
      final String message = data['message'];
      final Timestamp createdAt = data['createdAt'];
      final String id = data['id'];
      return Message(uid, message, createdAt, id);
    }).toList();
    this.messagelist = messagelist;

    for (var i = 0; i < messagelist.length; i++) {
      _addMessage(types.TextMessage(
        author: types.User(id: messagelist[i].uid),
        createdAt: messagelist[i].createdAt.millisecondsSinceEpoch,
        id: messagelist[i].id,
        text: messagelist[i].message,
      ));
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.name),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.construction),
              onPressed: () => setState(() {}),
            ),
          ],
          backgroundColor: Colors.deepPurple),
      body: Chat(
        messages: _messages,
        onAttachmentPressed: _handleAtachmentPressed,
        onMessageTap: _handleMessageTap,
        onPreviewDataFetched: _handlePreviewDataFetched,
        onSendPressed: _handleSendPressed,
        user: _user,
      ),
    );
  }
}

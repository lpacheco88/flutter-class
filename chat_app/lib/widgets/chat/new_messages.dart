import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessages extends StatefulWidget {
  @override
  _NewMessagesState createState() => _NewMessagesState();
}

class _NewMessagesState extends State<NewMessages> {
  final _controller = new TextEditingController();
  var _inputMessage = '';

  void _sendMessage() async {
    FocusScope.of(context).unfocus();
    final user = await FirebaseAuth.instance.currentUser();
    Firestore.instance.collection('chats').add(
      {
        'text': _inputMessage,
        'createdAt': Timestamp.now(),
        'userId': user.uid,
      },
    );
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: <Widget>[
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Send a message'),
              onChanged: (value) {
                setState(() {
                  _inputMessage = value;
                });
              },
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            onPressed: _inputMessage.trim().isEmpty ? null : _sendMessage,
          )
        ],
      ),
    );
  }
}

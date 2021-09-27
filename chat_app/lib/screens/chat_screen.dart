import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: Firestore.instance
              .collection('chats/RG8QA2ApJWJw6JHRb3Gn/messages')
              .snapshots(),
          builder: (ctx, AsyncSnapshot<QuerySnapshot> streamSnapShot) {
            if (streamSnapShot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            final documents = streamSnapShot.data!.documents;
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (ctx, index) => Container(
                padding: EdgeInsets.all(8),
                child: Text(documents[index]['text']),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Firestore.instance
              .collection('chats/RG8QA2ApJWJw6JHRb3Gn/messages')
              .add({'text': 'This was added here dawg'});
        },
      ),
    );
  }
}

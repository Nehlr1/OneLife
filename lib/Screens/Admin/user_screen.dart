import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'components/user_card.dart';

class UserScreen extends StatefulWidget {
  UserScreen({Key key}) : super(key: key);
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('users')
            .where('user_id',
                isNotEqualTo: FirebaseAuth.instance.currentUser.uid)
            .snapshots(),
        builder: (ctx, chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (!chatSnapshot.hasData) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (chatSnapshot.data == null)
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          final chatDocs = chatSnapshot.data.documents;
          return Scaffold(
            appBar: AppBar(
              title: Text('Users'),
            ),
            body: Container(
              child: ListView.builder(
                itemCount: chatDocs.length,
                itemBuilder: (ctx, index) => UserCard(
                  chatDocs[index]['username'],
                  chatDocs[index]['email'],
                  chatDocs[index]['user_id'],
                  //key: ValueKey(chatDocs[index].documentID),
                ),
              ),
            ),
          );
        });
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserCard extends StatefulWidget {
  UserCard(this.username, this.email, this.userId, {this.key});
  final Key key;
  final String username;
  final String email;
  final String userId;
  @override
  _UserCardState createState() => _UserCardState();
}

class _UserCardState extends State<UserCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shadowColor: Theme.of(context).primaryColor,
      elevation: 5,
      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
      child: Container(
        padding: EdgeInsets.only(
          left: 10,
          right: 5,
        ),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.username),
            Text(widget.email),
            IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: () {
                FirebaseFirestore.instance
                    .collection("users")
                    .where("user_id", isEqualTo: widget.userId)
                    .get()
                    .then((value) {
                  value.docs.forEach((element) {
                    FirebaseFirestore.instance
                        .collection("users")
                        .doc(element.id)
                        .delete()
                        .then((value) {
                      print("Success!");
                    });
                  });
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:one_life/constants.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ProfilePictureName extends StatefulWidget {
  // const ProfilePictureName({
  //   Key key,
  // }) : super(key: key);

  ProfilePictureName(this.isEditable);

  final bool isEditable;

  @override
  _ProfilePictureNameState createState() => _ProfilePictureNameState();
}

class _ProfilePictureNameState extends State<ProfilePictureName> {
  File _pickedImage;

  void _pickImage() async {
    final pickedImageFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 140,
      maxHeight: 140,
    );
    setState(() {
      _pickedImage = File(pickedImageFile.path);
    });
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('user_image')
          .child(FirebaseAuth.instance.currentUser.uid + 'jpg');

      String url;

      await ref.putFile(_pickedImage).whenComplete(() async {
        final _url = await ref.getDownloadURL();
        url = _url;
      });

      FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .update({'image_url': url});
    } catch (err) {
      print(err);
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    // This size provides the total height and width of the screen
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser.uid)
          .snapshots(),
      builder: (ctx, snapShot) {
        final doc = snapShot.data;
        if (snapShot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        return Container(
          // profile picture and name
          color: kPrimaryColor,
          height: size.height * 0.27,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Stack(
                children: <Widget>[
                  CircleAvatar(
                    backgroundColor: Theme.of(context).accentColor,
                    backgroundImage: doc['image_url'] != ''
                        ? NetworkImage(doc['image_url'])
                        : null,
                    radius: 70,
                  ),
                  if (widget.isEditable)
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: 15,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Icon(Icons.edit),
                        ),
                      ),
                    )
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
            ],
          ),
        );
      },
    );
  }
}

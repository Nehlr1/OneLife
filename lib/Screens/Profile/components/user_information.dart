import 'package:flutter/material.dart';
import 'package:one_life/Screens/Profile/components/profile_picture_name.dart';
import 'package:one_life/components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInformation extends StatefulWidget {
  const UserInformation({
    Key key,
  }) : super(key: key);
  @override
  _UserInformationState createState() => _UserInformationState();
}

class _UserInformationState extends State<UserInformation> {
  // File _userImageFile;

  // void _pickedImage(File image) {
  //   _userImageFile = image;
  // }

  var _isEditable = false;
  String _name = '';
  String _address = '';
  String _phone = '';
  String _bloodGroup = '';
  String _email = '';

  void setBool() {
    setState(() {
      _isEditable = !_isEditable;
    });
  }

  // void _submitUserInfo() async {
  //   UserCredential auth;

  // try {
  //   final ref = FirebaseStorage.instance
  //       .ref()
  //       .child('user_image')
  //       .child(auth.user.uid + 'jpg');

  //   String url;

  //   await ref.putFile(_userImageFile).whenComplete(() async {
  //     final _url = await ref.getDownloadURL();
  //     url = _url;
  //   });
  // } catch (err) {
  //   print(err);
  //   setState(() {
  //     _isEditable = !_isEditable;
  //   });
  // }
  // }

  @override
  Widget build(BuildContext context) {
    //Size size = MediaQuery.of(context).size;
    // This size provides the total height and width of the screen
    return Container(
      child: Column(
        // contains user information
        children: <Widget>[
          // SizedBox(
          //   height: size.height * 0.02,
          // ),
          // Text(
          //   "User Information",
          //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          // ),
          // SizedBox(
          //   height: size.height * 0.02,
          // ),
          // Divider(
          //   height: size.height * 0.01,
          //   color: Colors.grey,
          // ),
          ProfilePictureName(_isEditable),
          if (_isEditable)
            Card(
              child: Column(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.person),
                      hintText: 'Username',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _name = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.location_on),
                      hintText: 'Location',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _address = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.phone),
                      hintText: 'Phone number',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _phone = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.invert_colors),
                      hintText: 'Blood type',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _bloodGroup = value;
                      });
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: 'Email',
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      setState(() {
                        _email = value;
                      });
                    },
                  ),
                ],
              ),
            ),
          if (!_isEditable)
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users')
                  .doc(FirebaseAuth.instance.currentUser.uid)
                  .snapshots(),
              builder: (ctx, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                final doc = snapshot.data;
                return Column(
                  children: [
                    ListTile(
                      // Name
                      title: Text('Username'),
                      subtitle: Text(doc['username']),
                      leading: Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                    ),
                    ListTile(
                      // address
                      title: Text("Location"),
                      subtitle: Text(doc['location']),
                      leading: Icon(
                        Icons.location_on,
                        color: Colors.redAccent,
                      ),
                    ),
                    ListTile(
                      // Phone Number
                      title: Text("Phone Number"),
                      subtitle: Text(doc['phone']),
                      leading: Icon(
                        Icons.phone,
                        color: Colors.green,
                      ),
                    ),
                    ListTile(
                      // Blood type
                      title: Text("Blood Type"),
                      subtitle: Text(
                        doc['bloodType'],
                        style: TextStyle(color: Colors.red),
                      ),
                      leading: Icon(
                        Icons.invert_colors,
                        color: Colors.red,
                      ),
                    ),
                    ListTile(
                      // Email address
                      title: Text("Email"),
                      subtitle: Text(doc['email']),
                      leading: Icon(
                        Icons.email,
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ],
                );
              },
            ),
          if (!_isEditable)
            Container(
              padding: EdgeInsets.only(left: 30, right: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: RoundedButton(
                      text: 'EDIT',
                      color: Theme.of(context).primaryColor,
                      press: setBool,
                    ),
                  ),
                  Spacer(),
                  Expanded(
                    child: RoundedButton(
                      text: 'BACK',
                      color: Theme.of(context).primaryColor,
                      press: () {
                        Navigator.pop(context);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) {
                        //       return StartUp();
                        //     },
                        //   ),
                        // );
                      },
                    ),
                  ),
                ],
              ),
            ),
          if (_isEditable)
            RoundedButton(
              text: 'Save',
              color: Theme.of(context).primaryColor,
              press: () async {
                try {
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(FirebaseAuth.instance.currentUser.uid)
                      .set({
                    'username': _name,
                    'location': _address,
                    'phone': _phone,
                    'bloodType': _bloodGroup,
                    'email': _email,
                  });
                  setState(() {
                    _isEditable = !_isEditable;
                  });
                } catch (err) {
                  print(err);
                  setState(() {
                    _isEditable = !_isEditable;
                  });
                }
              },
            ),
          if (_isEditable)
            RoundedButton(
              text: 'BACK',
              color: Theme.of(context).primaryColor,
              press: () {
                Navigator.pop(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) {
                //       return StartUp();
                //     },
                //   ),
                // );
              },
            )
        ],
      ),
    );
  }
}

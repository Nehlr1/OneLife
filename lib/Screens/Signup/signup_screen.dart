import 'package:flutter/material.dart';
import 'package:one_life/Screens/Signup/components/body.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:one_life/Screens/Start/startup_screen.dart';

// the root of Sign up screen
class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _auth = FirebaseAuth.instance;
  var _isLoading = false;

  void _submitAuthForm(
    String email,
    String password,
    String username,
    bool isLogin,
    BuildContext ctx,
  ) async {
    UserCredential authResult;

    try {
      setState(() {
        _isLoading = true;
      });
      if (!isLogin) {
        authResult = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
      } else {
        authResult = await _auth.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        String uid = authResult.user.uid;
        await FirebaseFirestore.instance.collection('users').doc(uid).set({
          'username': username,
          'location': '',
          'phone': '',
          'bloodType': '',
          'email': email,
          'image_url': '',
          'is_Donor': false,
          'is_Admin': false,
          'user_id': uid,
        });
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return StartUp();
          },
        ),
      );
    } on PlatformException catch (err) {
      var message = 'An error occurred, pelase check your credentials!';

      if (err.message != null) {
        message = err.message;
      }

      Scaffold.of(ctx).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Theme.of(ctx).errorColor,
        ),
      );
      setState(() {
        _isLoading = false;
      });
    } catch (err) {
      print(err);
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(_submitAuthForm, _isLoading),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:one_life/Screens/Signup/components/background.dart';
import 'package:one_life/components/rounded_button.dart';
import 'package:one_life/components/rounded_input_field.dart';
import 'package:one_life/components/rounded_password_field.dart';

class Body extends StatefulWidget {
  Body(
    this.submitFn,
    this.isLoading,
  );
  final bool isLoading;
  final void Function(
    String email,
    String password,
    String userName,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;

  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPassword = '';

  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      _formKey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userPassword.trim(),
        _userName.trim(),
        _isLogin,
        context,
      );
    }
  }

  Widget buildUserName() {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return "UserName is Required";
        }
        return null;
      },
      onSaved: (String value) {
        setState(() {
          _userName = value;
        });
      },
    );
  }

  Widget buildEmail() {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value)) {
          return "Email is Required";
        }
        return null;
      },
      onSaved: (String value) {
        setState(() {
          _userEmail = value;
        });
      },
    );
  }

  Widget buildPassword() {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return "UserName is Required";
        }
        return null;
      },
      onSaved: (String value) {
        setState(() {
          _userPassword = value;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //This size provides the total height and width of the screen
    return Background(
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset(
                "assets/icons/blood_transfusion.svg",
                height: size.height * 0.30,
              ),
              if (_isLogin)
                RoundedInputField(
                  // for user to tpye in their Username
                  child: buildUserName(),
                  key: ValueKey('username'),
                  hintText: "Username",
                  onChanged: (value) {
                    _userName = value;
                  },
                ),

              RoundedInputField(
                // for user to tpye in their email address
                child: buildEmail(),
                key: ValueKey('email'),
                icon: Icons.email,
                hintText: "Email address",
                onChanged: (value) {
                  _userEmail = value;
                },
              ),
              RoundedPasswordField(
                // for user to tpye in their password
                child: buildPassword(),
                key: ValueKey('pasword'),
                onChanged: (value) {
                  _userPassword = value;
                },
              ),
              if (widget.isLoading) CircularProgressIndicator(),
              if (!widget.isLoading)
                RoundedButton(
                  // customized Sign up button
                  text: !_isLogin ? "LOG IN" : "SIGN UP",
                  press: _trySubmit,
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return StartUp();
                  //     },
                  //   ),
                  // );
                ),
              // SizedBox(
              //   // space between RoundedButton and AlreadyHaveAnAccountCheck
              //   height: size.height * 0.03,
              // ),
              if (!widget.isLoading)
                FlatButton(
                  textColor: Theme.of(context).primaryColor,
                  child: Text(!_isLogin
                      ? 'Create new account'
                      : 'I already have an account'),
                  onPressed: () {
                    setState(() {
                      _isLogin = !_isLogin;
                    });
                  },
                )
              // AlreadyHaveAnAccountCheck(
              //   login: false,
              //   press: () {
              //     // if pressed, leads to login screen

              //     // Navigator.push(
              //     //   context,
              //     //   MaterialPageRoute(
              //     //     builder: (context) {
              //     //       return LoginScreen();
              //     //     },
              //     //   ),
              //     // );
              //   },
              // ),
              //OrDivider(), // a divider
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     SocialIcon(
              //       // if pressed, leads to google login
              //       iconScr: "assets/icons/google-plus.svg",
              //       press: () {},
              //     ),
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }
}

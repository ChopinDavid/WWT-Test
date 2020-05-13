import 'package:flutter/material.dart';
import 'package:wwt_test/screens/login.dart';
import 'package:wwt_test/screens/signUp.dart';

class InitialPage extends StatefulWidget {
  @override
  _InitialPageState createState() => _InitialPageState();
}

class _InitialPageState extends State<InitialPage> {
  void navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  void navigateToSignUp() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Color.fromARGB(255, 1, 80, 161),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Image.asset("assets/logo.png"),
                margin: EdgeInsets.fromLTRB(100, 10, 100, 10),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("Login"),
                      onPressed: navigateToLogin,
                    ),
                    RaisedButton(
                      child: Text("Sign Up"),
                      onPressed: navigateToSignUp,
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 80, 161),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0), // here the desired height
          child: AppBar(
            title: Text("Login"),
            backgroundColor: Color.fromARGB(255, 2, 65, 128),
          )
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text(
                "Username",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
            TextField(
              style: TextStyle(
                  color: Colors.white
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
                "Password",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
            TextField(
              obscureText: true,
              style: TextStyle(
                color: Colors.white
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RaisedButton(
                    child: Text(
                        "Login"
                    ),
                    onPressed: segue,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void segue() {

  }
}
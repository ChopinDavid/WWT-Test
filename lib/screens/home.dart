import 'package:flutter/material.dart';

import 'package:wwt_test/services/auth.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 80, 161),
      appBar: AppBar(
        title: Text("Home"),
        backgroundColor: Color.fromARGB(255, 2, 65, 128),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () async {
              await AuthService.shared.signOut();
            },
            icon: Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: Text(
              "Sign Out",
              style: TextStyle(
                color: Colors.white
              ),
            )
          )
        ],
      ),
      body: Center(
        child: Text(
          "Welcome!",
          style: TextStyle(
            color: Colors.white
          ),
        ),
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wwt_test/models/user.dart';
import 'package:wwt_test/screens/home.dart';
import 'package:wwt_test/screens/initial.dart';

class Wrapper extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
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
                      CircularProgressIndicator(
                        valueColor:
                            new AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ));
    } else {
      if (user.uid == null) {
        return InitialPage();
      } else {
        return HomePage();
      }
    }
  }
}

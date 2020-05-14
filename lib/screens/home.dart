import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:wwt_test/models/user.dart';
import 'package:wwt_test/services/auth.dart';
import 'package:wwt_test/services/firestore.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User user;

  void getUser() async {
    FirebaseUser firebaseUser = await AuthService.shared.firebaseUser();
    String uid = AuthService.shared.userFromFirebaseUser(firebaseUser).uid;
    User user = await FirestoreService.shared.getUser(uid);
    setState(() => this.user = user);
  }

  @override
  void initState() {
    super.initState();
    getUser();
  }

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
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
        body: Center(child: Builder(builder: (context) {
          if (user != null) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Welcome ${user.name}!",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Builder(
                      builder: (context) {
                        if (user.photoUrl == null) {
                          return Image.asset(
                            "assets/user.png",
                            height: 200,
                            width: 200,
                            fit: BoxFit.cover,
                          );
                        } else {
                          return FadeInImage(
                            height: 200,
                            width: 200,
                            image: NetworkImage(user.photoUrl),
                            placeholder: AssetImage("assets/user.png"),
                            fit: BoxFit.cover,
                          );
                        }
                      },
                    )),
              ],
            );
          } else {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Welcome!",
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    "assets/user.png",
                    height: 200,
                    width: 200,
                  ),
                ),
              ],
            );
          }
        })));
  }
}

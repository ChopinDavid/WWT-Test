import 'package:firebase_auth/firebase_auth.dart';

import 'package:wwt_test/models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //Create User object based on FirebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //Sign in with email and password

  //Register with email and password
}
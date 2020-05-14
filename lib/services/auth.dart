import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:wwt_test/models/user.dart';
import 'package:wwt_test/services/storage.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  static AuthService shared = AuthService();

  //Create User object based on FirebaseUser
  User userFromFirebaseUser(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : User();
  }

  Future firebaseUser() {
    return _auth.currentUser();
  }

  //Sign in with email and password
  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Register with email and password
  Future registerWithEmailPasswordNameImage(
      String email, String password, String name, File image) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser firebaseUser = result.user;
      User user = userFromFirebaseUser(firebaseUser);
      if (image != null) {
        user.photoUrl = await StorageService.shared.uploadFile(image, user.uid);
      }
      user.email = email;
      user.name = name;
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Sign out
  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //Listen for auth changes
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(userFromFirebaseUser);
  }
}

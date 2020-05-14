import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wwt_test/models/user.dart';

class FirestoreService {
  final Firestore _firestore = Firestore.instance;

  static FirestoreService shared = FirestoreService();

  void createUser(User user) async {
    await _firestore
        .collection("Users")
        .document(user.uid)
        .setData(user.toMap());
  }

  Future getUser(String uid) async {
    User user;
    await _firestore.collection("Users").document(uid).get().then((value) {
      Map<String, dynamic> userMap = value.data;
      if (userMap == null) {
        return;
      }
      String name = userMap["name"] as String;
      String email = userMap["email"] as String;
      String photoUrl = userMap["photoUrl"] as String;
      user = User(uid: uid, name: name, email: email, photoUrl: photoUrl);
    });
    return user;
  }
}

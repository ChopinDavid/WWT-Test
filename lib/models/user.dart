

class User {
  final String uid;
  String name;
  String email;
  String photoUrl;

  User({this.uid, this.name, this.email, this.photoUrl});

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
      "photoUrl": photoUrl,
    };
  }
}

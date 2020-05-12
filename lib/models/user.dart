class User {
  final String uid;
  String name;
  String email;

  User({ this.uid, this.name, this.email });

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "name": name,
      "email": email,
    };
  }
}
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;

import 'package:wwt_test/models/user.dart';
import 'package:wwt_test/services/auth.dart';
import 'package:wwt_test/services/firestore.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  String email = "";
  String name = "";
  String password = "";
  String error = "";

  File file;
  String fileName = '';
  String operationText = '';
  bool isUploaded = true;
  String result = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 80, 161),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50.0), // here the desired height
        child: AppBar(
          title: Text("Sign Up"),
          backgroundColor: Color.fromARGB(255, 2, 65, 128),
        )
      ),
      body: Container(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                TextFormField(
                  style: TextStyle(
                      color: Colors.white
                  ),
                  decoration: InputDecoration(
                      hintText: "Email",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      )
                  ),
                  validator: (val) => val.isEmpty ? "Enter an email address" : null,
                  onChanged: (val) {
                    setState(() => email = val);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  style: TextStyle(
                      color: Colors.white
                  ),
                  decoration: InputDecoration(
                      hintText: "Display Name",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      )
                  ),
                  validator: (val) => val.isEmpty ? "Enter a display name" : null,
                  onChanged: (val) {
                    setState(() => name = val);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  style: TextStyle(
                      color: Colors.white
                  ),
                  decoration: InputDecoration(
                      hintText: "Password",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      )
                  ),
                  validator: (val) => val.length < 8 ? "Enter a password 8+ characters long" : null,
                  onChanged: (val) {
                    setState(() => password = val);
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  style: TextStyle(
                      color: Colors.white
                  ),
                  decoration: InputDecoration(
                      hintText: "Repeat Password",
                      hintStyle: TextStyle(
                        color: Colors.white,
                      )
                  ),
                  validator: (val) => val != password ? "Passwords must match" : null,
                ),
                SizedBox(height: 20),
                Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: file == null
                          ? AssetImage('assets/user.png')
                          : FileImage(file),
                    ),
                  ),
                  child: new FlatButton(
                    clipBehavior: Clip.hardEdge,
                      padding: EdgeInsets.all(0.0),
                      onPressed: filePicker,
                      child: null,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                          side: BorderSide(
                              color: Colors.white
                          )
                      ),
                  ),
                ),
                SizedBox(height: 20),
                RaisedButton(
                  child: Text(
                      "Sign Up"
                  ),
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      dynamic result = await AuthService.shared.registerWithEmailPasswordName(email, password, name);
                      if (result == null) {
                        setState(() => error = "Please supply a valid email");
                      } else {
                        setState(() => error = "");
                        FirestoreService.shared.createUser(result as User);
                        Navigator.pop(context);
                        print("Successfully registered user!");
                      }
                    }
                  },
                )
              ],
            ),
          )
        )
      ),
    );
  }

  filePicker() async {
    try {
      file = await FilePicker.getFile(type: FileType.image);
      setState(() {
        fileName = p.basename(file.path);
      });
    } on PlatformException catch (e) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Sorry...'),
              content: Text('Unsupported exception: $e'),
              actions: <Widget>[
                FlatButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            );
          }
      );
    }
  }
}
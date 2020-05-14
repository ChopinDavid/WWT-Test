import 'dart:io';

import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:wwt_test/models/user.dart';
import 'package:wwt_test/services/auth.dart';
import 'package:wwt_test/services/firestore.dart';
import 'package:wwt_test/services/storage.dart';
import 'package:dart_notification_center/dart_notification_center.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  bool _saving = false;

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
            )),
        body: LoadingOverlay(
            color: Color.fromARGB(255, 1, 80, 161),
            opacity: 0.75,
            progressIndicator: CircularProgressIndicator(
              valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
            ),
            child: Container(
                child: Form(
                    key: _formKey,
                    child: SingleChildScrollView(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          TextFormField(
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: "Email",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                )),
                            validator: (val) =>
                                val.isEmpty ? "Enter an email address" : null,
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            textCapitalization: TextCapitalization.words,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: "Display Name",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                )),
                            validator: (val) =>
                                val.isEmpty ? "Enter a display name" : null,
                            onChanged: (val) {
                              setState(() => name = val);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            obscureText: true,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: "Password",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                )),
                            validator: (val) => val.length < 8
                                ? "Enter a password 8+ characters long"
                                : null,
                            onChanged: (val) {
                              setState(() => password = val);
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                            obscureText: true,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: "Repeat Password",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                )),
                            validator: (val) =>
                                val != password ? "Passwords must match" : null,
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
                              onPressed: setFile,
                              child: null,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(100),
                                  side: BorderSide(color: Colors.white)),
                            ),
                          ),
                          SizedBox(height: 20),
                          RaisedButton(
                            child: Text("Sign Up"),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                setState(() {
                                  _saving = true;
                                });
                                dynamic result = await AuthService.shared
                                    .registerWithEmailPasswordNameImage(
                                        email, password, name, file);
                                if (result == null) {
                                  setState(() =>
                                      error = "Please supply a valid email");
                                  _saving = false;
                                } else {
                                  setState(() => error = "");
                                  User user = result as User;
                                  FirestoreService.shared
                                      .createUser(user);
                                  DartNotificationCenter.post(channel: "UserUpdated");
                                  Navigator.pop(context);
                                  print("Successfully registered user!");
                                }
                              }
                            },
                          )
                        ],
                      ),
                    ))),
            isLoading: _saving));
  }

  void setFile() async {
    dynamic result = await StorageService.shared.filePicker();
    if (result == null) {
      return;
    }
    setState(() {
      result is File ? file = result : showError(result as Error);
    });
  }

  void showError(Error e) {
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
        });
  }
}

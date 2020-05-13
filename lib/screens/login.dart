import 'package:flutter/material.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:wwt_test/services/auth.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  bool _loading = false;

  String email = "";
  String password = "";
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 80, 161),
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50.0), // here the desired height
          child: AppBar(
            title: Text("Login"),
            backgroundColor: Color.fromARGB(255, 2, 65, 128),
          )),
      body: LoadingOverlay(
        color: Color.fromARGB(255, 1, 80, 161),
        opacity: 0.75,
        progressIndicator: CircularProgressIndicator(
          valueColor: new AlwaysStoppedAnimation<Color>(Colors.white),
        ),
        child: Container(
          margin: EdgeInsets.all(20),
          child: Form(
            key: _formKey,
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
                SizedBox(height: 20),
                Text(
                  error,
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 14,
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      RaisedButton(
                        child: Text("Login"),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() {
                              _loading = true;
                            });
                            dynamic result = await AuthService.shared
                                .loginWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = "Either email or password is incorrect";
                                _loading = false;
                              });
                            } else {
                              setState(() => error = "");
                              Navigator.pop(context);
                              print("User successfully logged in!");
                            }
                          }
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        isLoading: _loading,
      ),
    );
  }
}

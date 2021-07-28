import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_articles/screens/auth/register.dart';
import 'package:flutter_articles/services/auth.dart';

import '../loading.dart';
import '../user_articles.dart';

class Login extends StatefulWidget {
  const Login({required this.toggleView});

  final Function toggleView;

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String email = "";
  String password = "";
  final AuthService _auth = AuthService();
  String error = "";
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            appBar: AppBar(
              title: Text("Login"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      obscureText: false,
                      onChanged: (val) {
                        setState(() => email = val.trim());
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0)),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: 'email',
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      obscureText: true,
                      onChanged: (val) {
                        setState(() => password = val.trim());
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(0.0)),
                        contentPadding:
                            EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        hintText: 'password',
                      ),
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blue,
                        minimumSize: Size(300, 50),
                      ),
                      onPressed: () async {
                        //checks if the form fields are properly filled out
                        if (_formKey.currentState!.validate()) {
                          
                          //tries to create a new login
                          dynamic result = await _auth
                              .loginWithEmailAndPassword(email, password);
                          if (result == null) {
                            setState(() => error = 'could not sign in user');
                          }
                        } else {
                          setState(() {
                            error = 'please supply a valid email';
                            loading = false;
                          });
                        }
                      },
                      child: Text('Login'),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.white,
                        backgroundColor: Colors.blue,
                        minimumSize: Size(300, 50),
                      ),
                      onPressed: () async {
                        dynamic result = await _auth.signInAnon();
                        result == null
                            ? print('error singing in')
                            : print(result);
                      },
                      child: Text('Login as Anon'),
                    ),
                    SizedBox(height: 20),
                    TextButton(
                      style: TextButton.styleFrom(
                        primary: Colors.blue,
                        backgroundColor: Colors.white,
                        minimumSize: Size(300, 50),
                      ),
                      onPressed: () {
                        widget.toggleView();
                      },
                      child: Text('Create An Account'),
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
              ),
            ),
          );
  }
}

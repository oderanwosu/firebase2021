import 'package:flutter/material.dart';
import 'package:flutter_articles/screens/auth/login.dart';
import 'package:flutter_articles/services/auth.dart';

class RegisterAccount extends StatefulWidget {
  const RegisterAccount({required this.toggleView});

  final Function toggleView;

  @override
  _RegisterAccountState createState() => _RegisterAccountState();
}

class _RegisterAccountState extends State<RegisterAccount> {
  String name = "";
  String email = "";
  String password = "";
  String error = "";
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Register"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                obscureText: false,
                validator: (val) => val!.isEmpty ? 'Enter a name' : null,
                onChanged: (val) {
                  setState(() => name = val.trim());
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0)),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: 'name',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: false,
                validator: (val) => val!.isEmpty ? 'Enter an email' : null,
                onChanged: (val) {
                  setState(() => email = val.trim());
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0)),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  hintText: 'email',
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                obscureText: true,
                validator: (val) => val!.isEmpty ? 'Enter a password' : null,
                onChanged: (val) {
                  setState(() => password = val.trim());
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0.0)),
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
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
                  if (_formKey.currentState!.validate()) {
                    dynamic result = await _auth.registerWithEmailAndPassword(
                        email, password, name);
                  } else {
                    setState(() => error = 'please supply a valid email');
                  }
                },
                child: Text('Register'),
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
                child: Text('Login'),
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

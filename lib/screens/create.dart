import 'package:flutter/material.dart';
import 'package:flutter_articles/models/FlutterArticlesUser.dart';
import 'package:flutter_articles/models/flutterArticlesUser.dart';
import 'package:flutter_articles/screens/loading.dart';
import 'package:flutter_articles/services/auth.dart';
import 'package:flutter_articles/services/database.dart';

class CreateArticle extends StatefulWidget {
  const CreateArticle({Key? key}) : super(key: key);

  @override
  _CreateArticleState createState() => _CreateArticleState();
}

class _CreateArticleState extends State<CreateArticle> {
  var imageURL = "";
  var title = "";
  var articleText = "";
  String error = "";
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: loading
          ? Loading()
          : Scaffold(
              appBar: AppBar(
                title: Text("Create Articles"),
                leading: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                    )),
              ),
              floatingActionButton: FloatingActionButton.extended(
                  elevation: 2.0,
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => loading = true);

                      print(_auth.currentUser());
                    } else {
                      setState(() {
                        error = 'please supply a valid email';
                        loading = false;
                      });
                    }
                  },
                  label: Text("Post"),
                  icon: Icon(Icons.save_alt_outlined)),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: <Widget>[
                        TextFormField(
                          obscureText: false,
                          onChanged: (val) {
                            setState(() => title = val.trim());
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: 'Title',
                          ),
                        ),
                        SizedBox(height: 50),
                        TextFormField(
                          obscureText: false,
                          onChanged: (val) {
                            setState(() => imageURL = val.trim());
                          },
                          decoration: InputDecoration(
                            contentPadding:
                                EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            hintText: 'Image URL',
                          ),
                        ),
                        Container(
                          height: 800,
                          child: TextFormField(
                            obscureText: false,
                            onChanged: (val) {
                              setState(() => imageURL = val.trim());
                            },
                            maxLines: null,
                            expands: true,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              contentPadding:
                                  EdgeInsets.fromLTRB(20.0, 40.0, 40.0, 15.0),
                              hintText: 'Type Article',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }
}

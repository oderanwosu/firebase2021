import 'package:flutter/material.dart';
import 'package:flutter_articles/models/FlutterArticlesUser.dart';
import 'package:flutter_articles/models/article.dart';
import 'package:flutter_articles/screens/loading.dart';
import 'package:flutter_articles/services/auth.dart';
import 'package:flutter_articles/services/database.dart';

class EditArticle extends StatefulWidget {
  const EditArticle({required this.currentUser, required this.article});

  final Article article;

  final FlutterArticlesUser currentUser;

  @override
  _EditArticleState createState() => _EditArticleState();
}

class _EditArticleState extends State<EditArticle> {
  var imageURL = "";
  var title = "";
  var articleText = "";
  String error = "";
  String text = "";
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
                title: Text("Edit Articles"),
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
                      await DataBaseService(uid: widget.currentUser.uid)
                          .updateArticle(
                              widget.currentUser, imageURL, title, text);
                      setState(() => loading = true);
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
                          initialValue: widget.article.title,
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
                          initialValue: widget.article.imageURL,
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
                            initialValue: widget.article.text,
                            obscureText: false,
                            onChanged: (val) {
                              setState(() => text = val.trim());
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
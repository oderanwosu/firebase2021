import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_articles/models/article.dart';
import 'package:flutter_articles/models/flutterArticlesUser.dart';
import 'package:flutter_articles/screens/create.dart';
import 'package:flutter_articles/services/database.dart';

import 'loading.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({required this.currentUser, required this.article});

  final FlutterArticlesUser currentUser;
  final Article article;

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  FlutterArticlesUser owner = FlutterArticlesUser(uid: 'none');

  var author = '';
  @override
  Widget build(BuildContext context) {
    final dataRef = FirebaseDatabase.instance
        .reference()
        .child('users')
        .child(widget.article.ownerID);

    return StreamBuilder(
        stream: dataRef.onValue,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            snapshot.connectionState == ConnectionState.waiting
                ? Loading()
                : Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.active) {
            var dataVal = snapshot.data.snapshot.value;

            owner = FlutterArticlesUser(
                uid: dataVal["uid"],
                username: dataVal["username"],
                email: dataVal["email"]);

            ;
          }

          return Scaffold(
            appBar: AppBar(
              leading: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  )),
              elevation: 3.0,
              title: Text("Article"),
            ),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: double.infinity,
                  height: 230,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.article.imageURL),
                          fit: BoxFit.fill)),
                ),
                SizedBox(
                  height: 30.0,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            Text(
                              widget.article.title,
                              style: TextStyle(
                                  fontSize: 20.0, fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              owner.username.toString(),
                              style: TextStyle(fontSize: 15.0),
                              textAlign: TextAlign.left,
                            ),
                            Container(
                              child: (owner.uid == widget.currentUser.uid)
                                  ? Row(
                                      children: [
                                        Center(
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                                primary: Colors.white,
                                                backgroundColor: Colors.blue),
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          CreateArticle(
                                                              currentUser: widget
                                                                  .currentUser,
                                                              article: widget
                                                                  .article)));
                                            },
                                            child: Text('Edit Article'),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10.0,
                                        ),
                                        TextButton(
                                          style: TextButton.styleFrom(
                                              primary: Colors.white,
                                              backgroundColor: Colors.red),
                                          onPressed: () async {
                                            await DataBaseService()
                                                .deleteArticle(widget.article);
                                          },
                                          child: Text('Delete Article'),
                                        ),
                                      ],
                                    )
                                  : null,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          widget.article.text,
                          style: TextStyle(fontSize: 14),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}

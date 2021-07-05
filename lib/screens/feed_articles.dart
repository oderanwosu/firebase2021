import 'package:flutter/material.dart';
import 'package:flutter_articles/models/article.dart';
import 'package:flutter_articles/models/flutterArticlesUser.dart';

import 'package:flutter_articles/screens/user_articles.dart';
import 'package:flutter_articles/services/auth.dart';

import 'aricle_list.dart';
import 'create.dart';

class FeedArticles extends StatefulWidget {
  const FeedArticles({required this.currentUser, required this.articles});
  final List<Article> articles;
  final FlutterArticlesUser currentUser;

  @override
  _FeedArticlesState createState() => _FeedArticlesState();
}

class _FeedArticlesState extends State<FeedArticles> {
  AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(
              elevation: 3.0,
              title: Text("Flutter Articles"),
              actions: <Widget>[
                Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Builder(
                    builder: (context) => Center(
                      child: TextButton(
                        onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => UserArticles())),
                        child: Icon(
                          Icons.article,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {},
              child: Builder(
                builder: (context) => Center(
                  child: TextButton(
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CreateArticle(
                                  currentUser: widget.currentUser,
                                  article: Article(
                                      ownerID: "",
                                      imageURL: "",
                                      title: "",
                                      text: ""),
                                ))),
                    child: Icon(
                      Icons.add_circle_outline_outlined,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              elevation: 3.0,
            ),
            body: Column(
              children: [
                TextButton(
                    onPressed: () async => await _authService.signOut(),
                    child: Container(child: Text('Sign Out'))),
                ArticlesList(
                    articles: widget.articles, currentUser: widget.currentUser),
              ],
            )));
  }
}

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_articles/models/article.dart';
import 'package:flutter_articles/models/flutterArticlesUser.dart';
import 'package:flutter_articles/screens/feed_articles.dart';
import 'package:flutter_articles/screens/loading.dart';
import 'package:flutter_articles/services/database.dart';

class Feeds extends StatefulWidget {
  const Feeds({required this.currentUser});

  final FlutterArticlesUser currentUser;

  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> {
  final dataRef = FirebaseDatabase.instance.reference().child('articles');
  List<Article> articles = [];

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: dataRef.onValue,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            snapshot.connectionState == ConnectionState.waiting
                ? Loading()
                : Text('Something went wrong');
          } else if (snapshot.connectionState == ConnectionState.active) {
            articles = DataBaseService().articleListFromSnapshot(snapshot);
          }
          return FeedArticles(articles: articles, currentUser: widget.currentUser);
        });
  }
}

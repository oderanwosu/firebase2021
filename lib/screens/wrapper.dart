import 'package:flutter/material.dart';
import 'package:flutter_articles/models/flutterArticlesUser.dart';
import 'package:flutter_articles/screens/auth/authenticate.dart';
import 'package:flutter_articles/screens/auth/login.dart';
import 'package:flutter_articles/screens/feed_articles.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FlutterArticlesUser?>(context);
    return user == null ? Authenticate() : FeedArticles();
  }
}

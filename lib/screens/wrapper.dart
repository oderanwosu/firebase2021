import 'package:flutter/material.dart';
import 'package:flutter_articles/models/flutterArticlesUser.dart';
import 'package:flutter_articles/screens/auth/authenticate.dart';
import 'package:flutter_articles/screens/auth/login.dart';
import 'package:flutter_articles/screens/feed_articles.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FlutterArticlesUser?>(context);
    print(user);
    return user == null ? Authenticate() : FeedArticles();
  }
}

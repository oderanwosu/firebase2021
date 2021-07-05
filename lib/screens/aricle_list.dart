import 'package:flutter/material.dart';
import 'package:flutter_articles/models/article.dart';
import 'package:flutter_articles/models/flutterArticlesUser.dart';

import 'article.dart';

class ArticleThumbNail extends StatefulWidget {
  const ArticleThumbNail({required this.currentUser, required this.article});

  final Article article;
  final FlutterArticlesUser currentUser;

  @override
  _ArticleThumbNailState createState() => _ArticleThumbNailState();
}

class _ArticleThumbNailState extends State<ArticleThumbNail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: TextButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ArticlePage(currentUser: widget.currentUser, article: widget.article),
              ));
        },
        child: Card(
          elevation: 0.0,
          child: ListTile(
            leading: FlutterLogo(size: 72.0),
            title: Text(widget.article.title),
            subtitle:
                Text('A sufficiently long subtitle warrants three lines.'),
            isThreeLine: true,
          ),
        ),
      ),
    );
  }
}

class ArticlesList extends StatefulWidget {
  const ArticlesList({required this.currentUser, required this.articles
      /*required this.articleList, */
      });

  final List<Article> articles;
  final FlutterArticlesUser currentUser;
  //final List<String> articleList;
  @override
  _ArticlesListState createState() => _ArticlesListState();
}

class _ArticlesListState extends State<ArticlesList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.articles.length,
        itemBuilder: (context, index) {
          return ArticleThumbNail(
              currentUser: widget.currentUser, article: widget.articles[index]);
        });
  }
}

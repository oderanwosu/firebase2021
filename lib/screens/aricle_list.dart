import 'package:flutter/material.dart';

import 'article.dart';


class ArticleThumbNail extends StatefulWidget {
  const ArticleThumbNail(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.leadingLogo})
      : super(key: key);

  final String title;
  final String subtitle;
  final String leadingLogo;

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
                builder: (context) => ArticlePage(),
              ));
        },
        child: Card(
          elevation: 0.0,
          child: ListTile(
            leading: FlutterLogo(size: 72.0),
            title: Text('Three-line ListTile'),
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
  const ArticlesList({
    Key? key,
    /*required this.articleList, */
  }) : super(key: key);

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
        itemCount: 5,
        itemBuilder: (context, index) {
          return ArticleThumbNail(
              title: "How to do Something",
              subtitle: "Learn How to do something",
              leadingLogo: "Hello");
        });
  }
}

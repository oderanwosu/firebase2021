import 'package:flutter/material.dart';

import 'aricle_list.dart';
import 'create.dart';

class UserArticles extends StatefulWidget {
  const UserArticles({Key? key}) : super(key: key);

  @override
  _UserArticlesState createState() => _UserArticlesState();
}

class _UserArticlesState extends State<UserArticles> {
  @override
  Widget build(BuildContext context) {
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
          title: Text("My Articles"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Builder(
            builder: (context) => Center(
                // child: TextButton(
                //   onPressed: () => Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => CreateArticle(currentUser: cu,))),
                //   child: Icon(
                //     Icons.add_circle_outline_outlined,
                //     color: Colors.white,
                //   ),
                // ),
                ),
          ),
          elevation: 3.0,
        ),
        body: Container());
  }
}

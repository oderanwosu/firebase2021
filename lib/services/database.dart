import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_articles/models/article.dart';
import 'package:flutter_articles/models/flutterArticlesUser.dart';
import 'package:flutter_articles/services/auth.dart';
import 'package:uuid/uuid.dart';

class DataBaseService {
  final connection = FirebaseDatabase.instance.reference();
  final DatabaseReference articlesCollection =
      FirebaseDatabase.instance.reference().child('articles');

  DataBaseService({uid});

  String uid = '';

  Future<void> updateFlutterArticlesUser(user, username) async {
    final usersReference = connection.child('users').child(user.uid);
    usersReference.set({
      'uid': user.uid,
      'email': user.email,
      'username': username,
      //add as many attributes as you want
    });
  }

  Future<void> updateArticle(user, imageURL, title, text, {id}) async {
    id == null ? Uuid().v1() : id = id;
    final articleReference = connection.child('articles').child(id);
    print('Article ID: ' + id);
    articleReference.set({
      'uid': id,
      'ownerID': user.uid,
      'title': title,
      'imageURL': imageURL,
      'text': text,
    });
  }

  List<Article> articleListFromSnapshot(AsyncSnapshot snapshot, {condition}) {
    condition == null ? condition = true : condition = condition;
    List<Article> list = [];
    if (snapshot.data.snapshot.value == null) {
      return list;
    } else {
      Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
      map.forEach((key, value) {
        if (condition) {
          list.add(Article(
              uid: value["uid"],
              ownerID: value["ownerID"],
              imageURL: value['imageURL'],
              title: value["title"],
              text: value['text']));
        }
      });

      return list;
    }
  }

  Future<void> deleteArticle(Article article) async {
    String id = article.uid.toString();
    final articleReference = connection.child('articles').child(id);
    articleReference.remove();
  }
}

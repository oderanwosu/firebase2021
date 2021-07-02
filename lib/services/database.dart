import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_articles/models/flutterArticlesUser.dart';
import 'package:flutter_articles/services/auth.dart';

class DataBaseService {
  final connection = FirebaseDatabase.instance.reference();

  DataBaseService({required this.uid});

  String uid = '';

  Future<void> saveFlutterArticlesUser(user, username) async {
    final usersReference = connection.child('users').child(user.uid);
    usersReference.set({
      'uid': user.uid,
      'email': user.email,
      'username': username,
      //add as many attributes as you want
    });

    Future<void> saveArticle(FlutterArticlesUser user, imageURL, title, text) async {
      final articleReference = connection.child('users').child(user.uid);

      articleReference.set({
        'uid': uid,
        'title': title,
        'imageURL': imageURL,
        'text': text,
      });
    }
  }
}

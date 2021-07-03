import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_articles/models/flutterArticlesUser.dart';
import 'package:flutter_articles/services/auth.dart';
import 'package:uuid/uuid.dart';

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
  }

  Future<void> saveArticle(user, imageURL, title, text) async {
    var id = Uuid().v1();
    final articleReference =
        connection.child('users').child(user.uid).child('articles').child(id);
    print('Article ID: ' + id);
    articleReference.set({
      'uid': id,
      'ownerID': uid,
      'title': title,
      'imageURL': imageURL,
      'text': text,
    });
  }
}

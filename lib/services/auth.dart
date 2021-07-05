import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_articles/models/flutterArticlesUser.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_articles/services/database.dart';

class AuthService {
  //sign in email & password
  final FirebaseAuth _auth = FirebaseAuth.instance;
  
  
  //create user obj based on FirebaseUser

  FlutterArticlesUser? _userFromFirebaseUser(User? user) {
    return user != null
        ? FlutterArticlesUser(uid: user.uid, email: user.email)
        : null;
  }

  FlutterArticlesUser? userFromFirebaseUser(User? user, username) {
    return user != null
        ? FlutterArticlesUser(
            uid: user.uid, email: user.email, username: username)
        : null;
  }

  // auth change user stream
  Stream<FlutterArticlesUser?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  //sign in anon
  Future signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future registerWithEmailAndPassword(String email, String password, String username) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      User? user = result.user;
      DataBaseService(uid: user!.uid).updateFlutterArticlesUser(user, username);

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future loginWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
  
   Future<FlutterArticlesUser?> currentUser() async {
    User user =  _auth.currentUser!;
    return _userFromFirebaseUser(user);
  }

}


import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_articles/designs/themes.dart';
import 'package:flutter_articles/screens/auth/authenticate.dart';
import 'package:flutter_articles/screens/feed_articles.dart';

import 'package:provider/provider.dart';

import 'models/flutterArticlesUser.dart';
import 'screens/auth/login.dart';
import 'screens/auth/register.dart';
import 'screens/feeds.dart';
import 'screens/loading.dart';
import 'services/auth.dart';

void main() => runApp(
    ChangeNotifierProvider(create: (context) => ProjTheme(), child: MyApp()));

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _initialized = false;
  bool _error = false;

  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_error) {
      print(_error);
      return Container();
    }

    // Show a loader until FlutterFire is initialized
    if (!_initialized) {
      return Loading();
    }

    return Streamer();
  }
}

class Streamer extends StatefulWidget {
  const Streamer({Key? key}) : super(key: key);

  @override
  _StreamerState createState() => _StreamerState();
}

class _StreamerState extends State<Streamer> {
  final _streamProvider = AuthService().user;

  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ProjTheme>(context);
    return MaterialApp(
      theme: theme.currentTheme,
      home: StreamBuilder(
          stream: _streamProvider,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return snapshot.connectionState == ConnectionState.waiting
                  ? Loading()
                  : Authenticate();
            } else {
              return Feeds(
                currentUser: snapshot.data,
              );
            }
          }),
    );
  }
}

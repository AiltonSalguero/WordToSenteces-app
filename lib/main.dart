import 'package:flutter/material.dart';

import 'package:sentence/pages/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  static final homePageKey = GlobalKey<HomePageState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WordToSentences',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
        key: homePageKey,
      ),
      
      // routes: <String, WidgetBuilder>{
      //   '/search' : (BuildContext context) => WordEntryPage(),
      //   '/favorites' : (BuildContext context) => FavoritesPage(),
      //   '/sentences' : (BuildContext context) => SentencesPage(),
      // },
    );
  }
}

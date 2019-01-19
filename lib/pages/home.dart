import 'package:flutter/material.dart';

import 'package:sentence/pages/word_entry.dart';
import 'package:sentence/pages/favorites.dart';
import 'package:sentence/pages/sentences.dart';
import '../data/db_helper.dart';
import '../main.dart';

import 'package:sentence/model/sentence.dart';

import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';

class HomePage extends StatefulWidget {
  /// Aniade una tributo "key" a HomePage
  HomePage({Key key}) : super(key: key);

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  TabController tabBarController;
  String word = "";

  static var favoriteSentences = List<Sentence>();
  final dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: TabBarView(
          controller: tabBarController,
          children: <Widget>[
            WordEntryPage(),
            SentencesPage(),
            FavoritesPage(),
          ],
        ),
        
        bottomNavigationBar: FancyBottomNavigation(
          
          tabs: [
            TabData(iconData: Icons.mode_edit, title: "Home"),
            TabData(iconData: Icons.toc, title: "Sentences"),
            TabData(iconData: Icons.favorite, title: "Favorites")
          ],
          onTabChangedListener: (position) => _navigateTo(position),
        ),
      ),
    );
  }

  @override
  void initState() {
    dbHelper.getSentences().then((favs) {
      favoriteSentences = favs;
    });

    super.initState();
    tabBarController = TabController(
      vsync: this,
      length: 3,
    );
  }

  @override
  void dispose() {
    tabBarController.dispose();
    super.dispose();
  }

  void _navigateTo(int pos) {
    setState(() {
      MyApp.homePageKey.currentState.tabBarController.animateTo(pos);
    });
  }
}

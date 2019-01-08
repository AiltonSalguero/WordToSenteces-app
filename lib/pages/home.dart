import 'package:flutter/material.dart';

import 'package:sentence/pages/word_entry.dart';
import 'package:sentence/pages/favorites.dart';
import 'package:sentence/pages/sentences.dart';
import 'package:sentence/widgets/fancy_tab_bar.dart';
import 'package:sentence/widgets/tab_item.dart';

import 'package:sentence/model/sentence.dart';

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
        bottomNavigationBar: FancyTabBar(),
      ),
    );
  }

  @override
  void initState() {
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
}

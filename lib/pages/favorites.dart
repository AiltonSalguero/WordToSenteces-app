import 'package:flutter/material.dart';
import 'package:sentence/data/db_helper.dart';

import 'package:sentence/model/sentence.dart';

class FavoritesPage extends StatefulWidget {
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {

  @override
  Widget build(BuildContext context) {
    final Iterable<ListTile> tiles = DBHelper.favoriteSentences.map(
      (Sentence favoriteNames) {
        return ListTile(
          title: Text(
            favoriteNames.text,
            //style: _biggerFont,
          ),
        );
      },
    );
    final List<Widget> divided = ListTile.divideTiles(
      context: context,
      tiles: tiles,
    ).toList();

    return ListView(
        children: divided,
        //children: <Widget>[Text("data")],
    );
  }
}

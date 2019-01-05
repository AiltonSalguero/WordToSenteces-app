import 'package:flutter/material.dart';

import 'package:sentence/widgets/fancy_tab_bar.dart';
import 'package:sentence/widgets/tab_item.dart';

class WordEntryPage extends StatefulWidget {
  _WordEntryPageState createState() => _WordEntryPageState();
}

class _WordEntryPageState extends State<WordEntryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Text("data"),
      ),

      bottomNavigationBar: FancyTabBar(),
    );
  }
}

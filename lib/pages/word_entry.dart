import 'package:flutter/material.dart';
import '../main.dart';

import 'package:sentence/data/api_helper.dart';

class WordEntryPage extends StatefulWidget {
  WordEntryPageState createState() => WordEntryPageState();
}

class WordEntryPageState extends State<WordEntryPage> {
  final apiHelper = new ApiHelper();

  bool _isComposing = false;
  final _textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(
          "Search...",
          style: TextStyle(
            fontSize: 64,
          ),
        ),
        Text(
          "in",
          style: TextStyle(
            fontSize: 48,
          ),
        ),
        Text(
          "Oxford",
          style: TextStyle(
            fontSize: 72,
          ),
        ),
        Text(
          "Dictionary",
          style: TextStyle(
            fontSize: 72,
          ),
        ),
        Container(
          padding: EdgeInsets.all(16),
          child: Row(
            children: [
              Flexible(
                child: TextField(
                  controller: _textController,
                  onSubmitted: _handleSubmitted,
                  onChanged: _handleMessageChanged,
                  decoration: InputDecoration(
                    hintText: "Search...",
                    contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                  horizontal: 4.0,
                ),
                child: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _isComposing
                      ? () => _handleSubmitted(_textController.text)
                      : null,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _handleSubmitted(String text) {
    apiHelper.getDataFromUrl(_textController.text);

    ApiHelper.currentWord = text[0].toUpperCase() + text.substring(1);
    _textController.clear();

    MyApp.homePageKey.currentState.tabBarController.animateTo(1);

    setState(() {
      _isComposing = false;
    });
  }

  void _handleMessageChanged(String text) {
    setState(() {
      _isComposing = text.length > 0;
    });
  }
}

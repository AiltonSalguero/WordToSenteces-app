import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../main.dart';

import 'package:sentence/model/sentence.dart';
import 'package:sentence/pages/sentences.dart';

class WordEntryPage extends StatefulWidget {
  WordEntryPageState createState() => WordEntryPageState();
}

class WordEntryPageState extends State<WordEntryPage> {
  static SentencesExample sentencesExample;

  static String word = "";

  bool _isComposing = false;
  final _textController = TextEditingController();

  void _searchSentences() {}

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
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
                    ? () => _getDataFromUrl(_textController
                        .text) //_handleSubmitted(_textController.text)
                    : null,
                //onPressed: _textController.text.toString().isEmpty ? () => print("yes") : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<Null> _getDataFromUrl(text) async {
    final _app_id = "c078a9d0";
    final _app_key = "fa8b3145a7f435b135000eb889afba4a";

    var response = await http.get(Uri.encodeFull(_urlWithSentencesOf(text)),
        headers: {
          'Accept': 'application/json',
          'app_id': _app_id,
          'app_key': _app_key
        });

    /// Converts JSON to an array
    var decodedData = json.decode(response.body);
    print(response.body);
    print(decodedData['results'][0]['lexicalEntries'][0]);

    sentencesExample = SentencesExample.fromJson(
        decodedData['results'][0]['lexicalEntries'][0]);
    

    MyApp.homePageKey.currentState.tabBarController.animateTo(1);
    word = _textController.text;
    _textController.clear();

    setState(() {
      _isComposing = false;
    });
  }

  String _urlWithSentencesOf(word) {
    final String language = "en";
    final wordToLowerCase = word
        .toLowerCase(); //word id is case sensitive and lowercase is required
    return "https://od-api.oxforddictionaries.com:443/api/v1/entries/" +
        language +
        "/" +
        wordToLowerCase +
        "/sentences";
  }

  void _handleSubmitted(String text) {
    MyApp.homePageKey.currentState.tabBarController.animateTo(1);

    //_getDataFromUrl(_urlWithSentencesOf(_textController.text));
    word = _textController.text;
    _textController.clear();

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

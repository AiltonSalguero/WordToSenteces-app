import 'package:flutter/material.dart';

import 'package:sentence/pages/word_entry.dart';
import 'package:sentence/model/sentence.dart';

import 'package:sentence/data/db_helper.dart';

import 'home.dart';

class SentencesPage extends StatefulWidget {
  SentencesPageState createState() => SentencesPageState();
}

class SentencesPageState extends State<SentencesPage> {
  String _currentWord = WordEntryPageState.currentWord;
  String _lexicalCategory = WordEntryPageState.lexicalCategory;

  final _sentencesExample = WordEntryPageState.sentencesExample;

  final dbHelper = DBHelper();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WordEntryPageState.sentencesExample == null
        ? _buildWaiting()
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              _buildHeader(),
              Container(
                child: _buildListOfSentences(),
              )
            ],
          );
  }

  Widget _buildHeader() {
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            "$_currentWord",
            style: TextStyle(
              fontSize: 40,
            ),
          ),
          Text("$_lexicalCategory."),
        ],
      ),
    );
  }

  Widget _buildWaiting() {
    return Center(
      child: Text("List of sentences.", style: TextStyle(fontSize: 48),),
    );
  }

  Widget _buildListOfSentences() {
    return Flexible(
      child: Container(
        child: ListView.builder(
          itemCount: _sentencesExample.length(),
          itemBuilder: (_, index) => _buildTextRow(
                _sentencesExample.sentence[index],
              ),
        ),
      ),
    );
  }

  Widget _buildTextRow(Sentence sen) {
    return Container(
      margin: EdgeInsets.only(
        left: 12,
        right: 16,
      ),
      child: ListTile(
        subtitle: Text("Regions: ${sen.regions}"),
        title: Container(
          child: Text(
            sen.text.toString(),
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),
        trailing: _showFavIcon(sen),
      ),
    );
  }

  Widget _showFavIcon(Sentence generatedSentence) {
    // Blank or red
    print("Fav icon of ${generatedSentence.text}");
    bool isFavorite = false;
    for (int i = 0; i < HomePageState.favoriteSentences.length; i++) {
      if (HomePageState.favoriteSentences[i].text == generatedSentence.text) {
        isFavorite = true;
        break;
      }
      ;
    }

    return GestureDetector(
      child: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.red : null,
      ),
      onTap: () => _addOrRemoveFavorite(isFavorite, generatedSentence),
    );
  }

  /// Interactivity for the fav icon
  void _addOrRemoveFavorite(bool isFavorite, Sentence generatedSentence) {
    print("CLICKED");
    setState(() {
      if (isFavorite) {
        HomePageState.favoriteSentences.remove(generatedSentence);
        dbHelper.deleteSentence(generatedSentence);
      } else {
        HomePageState.favoriteSentences.add(generatedSentence);
        dbHelper.addNewSentence(generatedSentence);
      }
      ;
    });
  }
}

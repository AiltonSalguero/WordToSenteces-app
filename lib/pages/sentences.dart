import 'package:flutter/material.dart';
import 'package:sentence/data/api_helper.dart';
import 'package:sentence/main.dart';

import 'package:sentence/pages/word_entry.dart';
import 'package:sentence/model/sentence.dart';

import 'package:sentence/data/db_helper.dart';
import 'package:sentence/util/loader.dart';

class SentencesPage extends StatefulWidget {
  SentencesPageState createState() => SentencesPageState();
}

class SentencesPageState extends State<SentencesPage> {
  final dbHelper = DBHelper();
  final apiHelper = ApiHelper();

  static String currentWord = "";
  static String lexicalCategory = "";
  final _textController = TextEditingController();

  //get http => null;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ApiHelper.sentencesExample == null
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
            "${ApiHelper.currentWord}",
            style: TextStyle(
              fontSize: 40,
            ),
          ),
          Text("${ApiHelper.lexicalCategory}"),
        ],
      ),
    );

    // return Column(
    //   children: <Widget>[
    //     Container(
    //       padding: EdgeInsets.all(16),
    //       child: Row(
    //         children: [
    //           Flexible(
    //             child: TextField(
    //               controller: _textController,
    //               onSubmitted: _handleSubmitted,
    //               onChanged: _handleMessageChanged,
    //               decoration: InputDecoration(
    //                 hintText: "Search...",
    //                 contentPadding: EdgeInsets.fromLTRB(20, 10, 20, 10),
    //                 border: OutlineInputBorder(
    //                   borderRadius: BorderRadius.circular(20),
    //                 ),
    //               ),
    //             ),
    //           ),
    //           Container(
    //             margin: EdgeInsets.symmetric(
    //               horizontal: 4.0,
    //             ),
    //             child: IconButton(
    //               icon: Icon(Icons.search),
    //               onPressed: _isComposing
    //                   ? () =>
    //                       apiHelper.getDataFromUrl(_textController.text, this)
    //                   : null,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ],
    // );
  }

  Widget _buildWaiting() {
    return ColorLoader(
      radius: 15,
      dotRadius: 6,
    );
  }

  Widget _buildListOfSentences() {
    return Flexible(
      child: Container(
        child: ListView.builder(
          itemCount: ApiHelper.sentencesExample.length(),
          itemBuilder: (_, index) => _buildTextRow(
                ApiHelper.sentencesExample.sentence[index],
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
    for (int i = 0; i < DBHelper.favoriteSentences.length; i++) {
      if (DBHelper.favoriteSentences[i].text == generatedSentence.text) {
        isFavorite = true;
        break;
      }
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
        DBHelper.favoriteSentences.remove(generatedSentence);
        dbHelper.deleteSentence(generatedSentence);
      } else {
        DBHelper.favoriteSentences.add(generatedSentence);
        dbHelper.addNewSentence(generatedSentence);
      }
    });
  }
}

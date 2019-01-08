import 'package:flutter/material.dart';

import 'package:sentence/pages/word_entry.dart';
import 'package:sentence/model/sentence.dart';

class SentencesPage extends StatefulWidget {
  SentencesPageState createState() => SentencesPageState();
}

class SentencesPageState extends State<SentencesPage> {
  /// Current word
  String _word = WordEntryPageState.word;

  /// Contains all the saved sentences
  final _favoriteSentences = Set<Sentence>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Sentences with $_word",
          style: TextStyle(
            fontSize: 30,
          ),
        ),
        Container(
          child: WordEntryPageState.sentencesExample == null
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Flexible(
                  child: Container(
                    child: ListView.builder(
                      itemCount: WordEntryPageState.sentencesExample.length(),
                      itemBuilder: (_, index) => _buildTextRow(
                            WordEntryPageState.sentencesExample.sentence[index],
                          ),
                    ),
                  ),
                ),
        )
      ],
    );
  }

  Widget _buildTextRow(Sentence sen) {
    return Container(
      margin: EdgeInsets.only(
        left: 12,
        right: 16,
      ),
      // child: Card(
      //   margin: EdgeInsets.all(8),
      //   elevation: 3,
      //   child: Container(
      //     margin: EdgeInsets.all(16),
      //     child: Text(
      //       sen.text.toString(),
      //       style: TextStyle(
      //         fontSize: 20.0,
      //       ),
      //     ),
      //   ),
      // ),
      child: ListTile(
        subtitle: _showRegions(sen),
        title: Container(
          child: Text(
            sen.text.toString(),
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
        ),
        trailing: _showFavIcon(_favoriteSentences.contains(sen)),
      ),
    );
  }

  Widget _showRegions(Sentence sen) {
    String regions = "";
    for (var region in sen.regions) {
      regions += region;
    }
    return Text("Regions: $regions");
  }

  Widget _showFavIcon(bool isFavorite) {
    // Blank or red
    return Icon(
      isFavorite ? Icons.favorite : Icons.favorite_border,
      color: isFavorite ? Colors.red : null,
    );
  }
}

// Container(
//           alignment: FractionalOffset(0.95, 0),
//           child: Icon(
//             Icons.favorite_border,
//           ),
//         ),

import 'package:flutter/material.dart';

import 'package:sentence/pages/word_entry.dart';
import 'package:sentence/model/sentence.dart';

class SentencesPage extends StatefulWidget {
  SentencesPageState createState() => SentencesPageState();
}

class SentencesPageState extends State<SentencesPage> {
  String _word = WordEntryPageState.word;

  @override
  void initState() {
    super.initState();
  }

  static void update() {
    setState() {}
    ;
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
              :
              // : GridView.count(
              //     shrinkWrap: true,
              //     crossAxisCount: 1,
              //     padding: EdgeInsets.all(2.0),
              //     childAspectRatio: 6,
              //     children: WordEntryPageState.sentencesExample.sentence
              //         .map((sen) => _buildTextRow(sen))
              //         .toList(),
              //   ),
              Flexible(
                  child: Container(
                  child: ListView.builder(
                    itemCount: WordEntryPageState.sentencesExample.length(),
                    itemBuilder: (_, index) => _buildTextRow(
                          WordEntryPageState.sentencesExample.sentence[index],
                        ),
                  ),
                )),
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
      child: Card(
        elevation: 3,
        child: Row(
          children: <Widget>[
            Text(
              sen.text.toString(),
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            Container(
              alignment: FractionalOffset(0.95, 0),
              child: Icon(
                Icons.favorite_border,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

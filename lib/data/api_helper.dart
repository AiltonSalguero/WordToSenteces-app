import 'dart:async';
import 'dart:convert';

import 'package:sentence/model/sentence.dart';

import 'package:sentence/data/db_helper.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  static String currentWord;
  static String lexicalCategory;
  static SentencesExample sentencesExample;

  final dbHelper = DBHelper();

  final appId = "c078a9d0";
  final appKey = "fa8b3145a7f435b135000eb889afba4a";

  Future<Null> getDataFromUrl(text) async {
    print("------------------------------");
    var response = await http.get(Uri.encodeFull(urlWithSentencesOf(text)),
        headers: {
          'Accept': 'application/json',
          'app_id': appId,
          'app_key': appKey
        });

    print(response.body);
    /// Converts JSON to an array
    var decodedData = json.decode(response.body);

    sentencesExample = SentencesExample.fromJson(
        decodedData['results'][0]['lexicalEntries'][0]);

    lexicalCategory =
        decodedData['results'][0]['lexicalEntries'][0]['lexicalCategory'];
    print(decodedData);
  }

  String urlWithSentencesOf(String word) {
    // Word id is case sensitive and lowercase is required
    final String language = "en";
    final wordToLowerCase = word.toLowerCase();
    return "https://od-api.oxforddictionaries.com:443/api/v1/entries/" +
        language +
        "/" +
        wordToLowerCase +
        "/sentences";
  }
}

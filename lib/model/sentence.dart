class SentencesExample {
  List<Sentence> sentence;

  SentencesExample({this.sentence});

  SentencesExample.fromJson(Map<String, dynamic> json) {
    // Gets data from JSON
    if (json['sentences'] != null) {
      sentence = List<Sentence>();
      json['sentences'].forEach((sen) {
        sentence.add(Sentence.fromJson(sen));
      });
    }
  }

  Map<String, dynamic> toJson() {
    // Converts data to JSON
    final data = Map<String, dynamic>();
    if (this.sentence != null) {
      data['sentence'] = this.sentence.map((sen) => sen.toMap()).toList();
    }
  }

  int length(){
    return sentence.length;
  }
}

class Sentence {
  int id;
  String regions;
  String text;

  Sentence(this.regions, this.text);

  Sentence.fromJson(Map<String, dynamic> json) {
    // Gets data from JSON
    List<dynamic> regionsList = json['regions']; // Converts list to string
    regions = regionsList.join(', ');
    text = json['text'];
  }

  Map<String, dynamic> toMap() {
    // Converts data to JSON
    final data = Map<String, dynamic>();
    data['regions'] = this.regions;
    data['text'] = this.text;

    return data;
  }
}

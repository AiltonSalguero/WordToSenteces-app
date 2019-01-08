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
      data['sentence'] = this.sentence.map((sen) => sen.toJson()).toList();
    }
  }

  int length(){
    return sentence.length;
  }
}

class Sentence {
  List regions;
  List senselds;
  String text;

  Sentence(this.regions, this.senselds, this.text);

  Sentence.fromJson(Map<String, dynamic> json) {
    // Gets data from JSON
    regions = json['regions'];
    senselds = json['senselds'];
    text = json['text'];
  }

  Map<String, dynamic> toJson() {
    // Converts data to JSON
    final data = Map<String, dynamic>();
    data['regions'] = this.regions;
    data['senselds'] = this.senselds;
    data['text'] = this.text;

    return data;
  }
}

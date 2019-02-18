import "dart:async";
import "dart:io" as io;
import "package:path/path.dart";
import "package:path_provider/path_provider.dart";
import "package:sqflite/sqflite.dart";
import 'package:sentence/model/sentence.dart';

class DBHelper {
  final String tableName = "Sentence";
  static Database dbInstance;

  static var favoriteSentences = List<Sentence>();

  Future<Database> get db async {
    if (dbInstance == null) dbInstance = await initDB();
    return dbInstance;
  }

  /// Creates a Data Base
  initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "SentencesDB.db");
    var db = await openDatabase(path, version: 1, onCreate: onCreateFunc);

    return db;
  }

  /// Creates Table
  void onCreateFunc(Database db, int version) async {
    String query =
        'CREATE TABLE $tableName(id INTEGER PRIMARY KEY AUTOINCREMENT, regions TEXT, text TEXT);';
    await db.execute(query);
  }

  /// CRUD
  /// Get sentences
  Future<List<Sentence>> getSentences() async {
    var dbConnection = await db;
    List<Map> list = await dbConnection.rawQuery('SELECT * FROM $tableName');
    List<Sentence> sentences = new List();

    for (int i = 0; i < list.length; i++) {
      Sentence sentence = new Sentence("", "");
      sentence.id = list[i]['id'];
      sentence.regions = list[i]['regions'];
      sentence.text = list[i]['text'];

      sentences.add(sentence);
    }
    return sentences;
  }

  /// Adds a sentence
  void addNewSentence(Sentence sentence) async {
    var dbConnection = await db;
    String text = sentence.text.replaceAll("'", "''");
    String regions = sentence.regions.replaceAll("'", "''");
    String query =
        'INSERT INTO $tableName(regions, text) VALUES (\'$regions\', \'$text\')';
    await dbConnection.transaction((transaction) async {
      return await transaction.rawInsert(query);
    });
  }

  /// Updates a sentence
  void updateSentence(Sentence sentence) async {
    var dbConnection = await db;
    String text = sentence.text.replaceAll("'", "''");
    String regions = sentence.regions.replaceAll("'", "''");
    String query =
        'UPDATE $tableName SET regions=\'$regions\', text=\'$text\' WHERE id=${sentence.id}';
    await dbConnection.transaction((transaction) async {
      return await transaction.rawQuery(query);
    });
  }

  /// Deletes a sentence
  void deleteSentence(Sentence sentence) async {
    var dbConnection = await db;
    String text = sentence.text.replaceAll("'", "''");
    print("DELETING");
    String query = """DELETE FROM $tableName WHERE text="$text" """;
    await dbConnection.transaction((transaction) async {
      return await transaction.rawQuery(query);
    });
  }

  /// Search for a specific value
  Future<bool> containsSentence(Sentence sentence) async {
    var dbConnection = await db;
    String text = sentence.text.replaceAll("'", "''");
    List<Map> list = await dbConnection
        .rawQuery("""SELECT * FROM $tableName WHERE text=$text """);
    bool found;
    list.length == 0 ? found = false : found = true;
    return found;
  }
}

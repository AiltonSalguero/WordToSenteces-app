
import 'dart:async';

import 'package:sentence/model/sentence.dart';
import 'package:sentence/util/network_util.dart';

class RestData {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "";
  static final LOGIN_URL = BASE_URL + "/";

  // Future<Sentence> login(String username, String password) {
  //   return new Future.value(new Sentence(username, password));
  // }
}
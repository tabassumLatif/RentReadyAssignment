import 'dart:convert';

import '../model/Account.dart';

class JsonParseUtil{
  static List<Account> parseAccount(String responseBody) {
    final parsed = jsonDecode(responseBody)['value'].cast<Map<String, dynamic>>();
    return parsed.map<Account>((json) => Account.fromJson(json)).toList();
  }
}
import 'dart:convert';

import 'package:rent_ready_assignment/utils/JsonParseUtil.dart';

import '../model/Account.dart';
import 'NetworkConstants.dart';

class ApiController{

  static Future<List<Account>> getAccountList(String text) async {
    List<Account> list = [];
    var response = await NetworkConstants.client.post(NetworkConstants.accountList,
        headers: NetworkConstants.getHeader, body: jsonEncode({"Text": text}));
    if (response.statusCode == 200 && response.bodyString != null) {
      list = JsonParseUtil.parseAccount(response.bodyString ?? "[]");
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return list;
  }

}
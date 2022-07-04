import 'package:flutter/material.dart';
import 'package:flutter_aad_oauth/flutter_aad_oauth.dart';
import 'package:rent_ready_assignment/utils/JsonParseUtil.dart';

import '../model/Account.dart';
import 'NetworkConstants.dart';

class ApiController {

  static Future<List<Account>> getAccountList(String text, BuildContext context) async {
    NetworkConstants.getRedirectUri();
    var oauth = FlutterAadOauth(NetworkConstants.config);
    oauth.setContext(context);
    String? type = await oauth.getTokenType();
    String? idToken = await oauth.getAccessToken();
    print('token type: $type');
    print('idToken : $idToken');
    if (await oauth.tokenIsValid()) {
      String? accessToken = await oauth.getAccessToken();
      print('Access token: $accessToken');
      NetworkConstants.authToken = idToken!;
    }

    List<Account> list = [];
    var response = await NetworkConstants.client
        .get(NetworkConstants.accountList + (text.isEmpty ? "" : "?\$filter=contains(name,'$text')"), headers: NetworkConstants.headers);
    if (response.statusCode == 200 && response.bodyString != null) {
      list = JsonParseUtil.parseAccount(response.bodyString ?? "[]");
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
    return list;
  }


}

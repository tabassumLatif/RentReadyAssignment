import 'dart:convert';

import 'package:get/get.dart';

class NetworkConstants{
  static const String url = "https://aplusapi.webapptr.com/powerapp/";
  static const String _apiKey = "Aplus:70816501-edb9-4740-a16c-6a5efbc05d84";

  static const String accountList = "PowerApp/GetAccountList";

  static var client = GetHttpClient(
    baseUrl: NetworkConstants.url,
  );

  static get getAuthKey {
    String authKey = "$_apiKey:powerApp";
    return authKey;
  }

  static get getBasicAuth {
    return 'Basic ${base64Encode(utf8.encode(getAuthKey))}';
  }

  static get getHeader {
    return <String, String>{
      'authorization': getBasicAuth,
      'Accept': 'application/json',
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      "Access-Control-Allow-Credentials": "true",
      "Access-Control-Allow-Headers":
      "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      "Access-Control-Allow-Methods": "POST, OPTIONS"
    };
  }
}
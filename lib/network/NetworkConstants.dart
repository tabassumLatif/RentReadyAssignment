import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_aad_oauth/model/config.dart';
import 'package:get/get.dart';

class NetworkConstants {
  static const String url = "https://org627210a3.crm4.dynamics.com/";
  static const String accountList = "api/data/v9.2/accounts";

  static const String TENANT_ID = '3b046eb3-f0b2-42b9-a1ec-bd70df80ee29';
  static const String CLIENT_ID = '64e4d6a0-5e14-49d4-8de7-c806f403c476';
  static String scope = '';
  static String responseType = "";

  static const String authorizationUrl =
      "https://login.microsoftonline.com/common/oauth2/authorize?resource=$url";
  static const String webapiurl = "$url/api/data/v9.2/";

  static var client = GetHttpClient(
    baseUrl: NetworkConstants.url,
  );

  static final navigatorKey = GlobalKey<NavigatorState>();

  static late Object redirectUri;

  static void getRedirectUri() {
    if (kIsWeb) {
      scope = 'openid profile email offline_access user.read';
      responseType = 'token';
      final currentUri = Uri.base;
      redirectUri = 'https://localhost:60800';
    } else {
      scope = 'openid profile offline_access';
      responseType = 'code';
      redirectUri = 'https://localhost:60800';
    }
  }

  static Config config = Config(
      azureTenantId: TENANT_ID,
      clientId: CLIENT_ID,
      scope: scope,
      redirectUri: '$redirectUri',
      responseType: responseType);

  static String authToken = "";
  static var headers = {'Authorization': 'Bearer ${authToken.trim()}'};
}

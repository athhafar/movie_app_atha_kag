import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movie_app_provider_kag/services/api_endpoint.dart';

enum APIMethod {
  post,
  get,
}

class ApiServices {
  static var client = http.Client();

  static Future api({
    required String endPoint,
    required var type,
    String param = "",
    var requestBodyMap = const {},
    bool withToken = true,
  }) async {
    Map<String, String> headers = {};

    headers = {
      "Content-Type": "application/json",
      "accept": "application/json",
      "Authorization": "$bearerToken"
    };

    print('REQUEST BODY ${jsonEncode(requestBodyMap)}');

    var response;
    if (type == APIMethod.get) {
      response = await client.get(
        Uri.parse('$kBaseUrl$endPoint$param'),
        headers: headers,
      );
    } else if (type == APIMethod.post) {
      response = await client.post(
        Uri.parse('$kBaseUrl$endPoint$param'),
        headers: headers,
        body: requestBodyMap.toString().isNotEmpty
            ? null
            : jsonEncode(requestBodyMap),
      );
    }

    print('URI PARSE $kBaseUrl$endPoint$param');

    print('$endPoint RESPONSE BODY ${jsonEncode(response.body)}');

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      print('ERROR API SERVICES ${jsonDecode(response.body)}');
      return jsonDecode(response.body);
    }
  }
}

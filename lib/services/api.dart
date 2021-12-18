// You must use some API TOKEN, you can get here https://onesimpleapi.com/docs/url-unshorten

import 'dart:convert';

import 'package:http/http.dart' as http;

class Api {
  static const _baseUrl = 'pinterest-video-api.herokuapp.com';
  static const _token = 'YOUR_TOKEN_HERE';

  Future<String> get(String pinNumber) async {
    final uri = Uri.https(_baseUrl, pinNumber);
    final response = await http.get(uri);
    return response.body.replaceAll('"', '');
  }

  Future<String> unshort(String url) async {
    final uri = Uri.https('onesimpleapi.com', '/api/unshorten', {
      'token': _token,
      'url': url,
      'output': 'json',
    });
    final resp = await http.get(uri);
    if (resp.statusCode == 200) {
      String url = jsonDecode(resp.body)['data'];
      return _resolve(url);
    } else {
      throw Exception('Ocurred some problem =/\nStatus: ${resp.statusCode}');
    }
  }

  String _resolve(String url) {
    var init = 30;
    while (url[init] != '/') {
      init++;
    }
    return url.substring(0, init + 1);
  }

  static String getPinID(String url) {
    var init = 30;
    while (url[init] != '/') {
      init++;
    }
    return url.substring(30, init);
  }
}
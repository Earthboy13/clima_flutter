import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkMangaer {
  Uri uri;

  Future getData({String url}) async {
    uri = Uri.parse(url);
    print(uri);
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else
      print('Response status: ${response.statusCode}');
  }
}

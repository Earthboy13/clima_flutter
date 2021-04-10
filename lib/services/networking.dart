import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkMangaer {
  Uri uri;

  Future getData({String url}) async {
    //String apiKey = 'ece777c5b3c9b0e99d4c130e66b0664f';
    //'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$log&appid=$apiKey'
    uri = Uri.parse(url);
    print(uri);
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else
      print('Response status: ${response.statusCode}');
  }
}

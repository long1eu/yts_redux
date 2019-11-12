// File created by
// Lung Razvan <long1eu>
// on 12/11/2019

import 'dart:convert';

import 'package:http/http.dart';

class YtsApi {
  Future<List<String>> getMovies(int page) async {
    final Response result = await get('https://yts.lt/api/v2/list_movies.json?page=$page');

    return List<Map<String, dynamic>>.from(jsonDecode(result.body)['data']['movies'])
        .map<String>((Map<String, dynamic> movie) => movie['title'])
        .toList();
  }
}

void main() async {
  final YtsApi service = YtsApi();

  print(await service.getMovies(1));
}

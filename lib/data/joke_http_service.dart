import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;

import '../model/joke_model.dart';
import '../utils/const_app.dart';

class JokeHttpService {
  final _random = Random();

  Future<Joke> getRandomJoke() async {
    final uri = Uri.parse(jokesUrl);
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('$messageErrorJokesApi: ${response.statusCode}');
    }

    final decoded = json.decode(response.body);
    if (decoded is! List || decoded.isEmpty) {
      throw Exception(messageEmptyJokesApi);
    }

    final selected = decoded[_random.nextInt(decoded.length)];
    if (selected is! Map<String, dynamic>) {
      throw Exception(messageInvalidJokeData);
    }

    return Joke.fromJson(selected);
  }
}
import 'package:flutter/material.dart';

import '../data/joke_http_service.dart';
import '../model/joke_model.dart';

class JokeController extends ChangeNotifier {
  JokeController({JokeHttpService? service})
      : _service = service ?? JokeHttpService();

  final JokeHttpService _service;

  Joke? currentJoke;
  bool isLoading = false;
  String? errorMessage;

  Future<void> loadRandomJoke() async {
    isLoading = true;
    errorMessage = null;
    notifyListeners();

    try {
      currentJoke = await _service.getRandomJoke();
    } catch (_) {
      currentJoke = null;
      errorMessage = 'No s\'ha pogut obtenir un acudit nou.';
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
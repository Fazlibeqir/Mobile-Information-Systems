import 'package:flutter/material.dart';
import '../models/joke.dart';

class FavoriteJokesProvider with ChangeNotifier {
  List<Joke> _favoriteJokes = [];

  List<Joke> get favoriteJokes => _favoriteJokes;

  void addFavorite(Joke joke) {
    _favoriteJokes.add(joke);
    notifyListeners();
  }

  void removeFavorite(Joke joke) {
    _favoriteJokes.remove(joke);
    notifyListeners();
  }
}

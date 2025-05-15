import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/models/radio_station.dart';

class FavoritesProvider with ChangeNotifier {
  static const _prefsKey = 'favorite_stations';
  List<RadioStation> _favorites = [];

  List<RadioStation> get favorites => List.unmodifiable(_favorites);

  FavoritesProvider() {
    _loadFavorites();
  }

  void addFavorite(RadioStation station) {
    if (!_favorites.any((s) => s.streamUrl == station.streamUrl)) {
      _favorites.add(station);
      _saveFavorites();
      notifyListeners();
    }
  }

  void removeFavorite(RadioStation station) {
    _favorites.removeWhere((s) => s.streamUrl == station.streamUrl);
    _saveFavorites();
    notifyListeners();
  }

  bool isFavorite(RadioStation station) {
    return _favorites.any((s) => s.streamUrl == station.streamUrl);
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_prefsKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      _favorites = jsonList
          .map((jsonItem) => RadioStation.fromJson(jsonItem as Map<String, dynamic>))
          .toList();
      notifyListeners();
    }
  }

  Future<void> _saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _favorites.map((station) => station.toJson()).toList();
    await prefs.setString(_prefsKey, json.encode(jsonList));
  }
}

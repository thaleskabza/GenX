import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class PlayerProvider with ChangeNotifier {
  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _currentStation;
  bool _isPlaying = false;

  String? get currentStation => _currentStation;
  bool get isPlaying => _isPlaying;

  Future<void> play(String name, String url) async {
    _currentStation = name;
    await _audioPlayer.setUrl(url);
    _audioPlayer.play();
    _isPlaying = true;
    notifyListeners();
  }

  void togglePlayPause() {
    if (_audioPlayer.playing) {
      _audioPlayer.pause();
      _isPlaying = false;
    } else {
      _audioPlayer.play();
      _isPlaying = true;
    }
    notifyListeners();
  }
}

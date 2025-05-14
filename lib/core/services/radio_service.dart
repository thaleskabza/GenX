import 'package:just_audio/just_audio.dart';

class RadioService {
  final AudioPlayer _player = AudioPlayer();

  Future<void> play(String streamUrl) async {
    await _player.setUrl(streamUrl);
    _player.play();
  }

  void stop() {
    _player.stop();
  }

  Stream<PlayerState> get playerState => _player.playerStateStream;
}

import 'package:flutter/material.dart';
import '../../core/models/radio_station.dart';
import '../../core/services/radio_service.dart';
import '../../config/constants.dart';

class PlayerScreen extends StatefulWidget {
  final RadioStation station;

  const PlayerScreen({super.key, required this.station});

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  final RadioService _service = RadioService();
  bool _isPlaying = true;

  @override
  void initState() {
    super.initState();
    _playStream();
  }

  Future<void> _playStream() async {
    await _service.play(widget.station.streamUrl);
  }

  void _togglePlayback() {
    if (_isPlaying) {
      _service.stop();
    } else {
      _playStream();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void dispose() {
    _service.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final displayLogo = widget.station.logoUrl.isNotEmpty
        ? widget.station.logoUrl
        : defaultStationLogo;

    return Scaffold(
      appBar: AppBar(title: Text(widget.station.name)),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              displayLogo,
              height: 100,
              errorBuilder: (_, __, ___) =>
                  const Icon(Icons.radio, size: 100, color: Colors.grey),
            ),
            const SizedBox(height: 20),
            Text(
              widget.station.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              widget.station.country.isNotEmpty
                  ? 'Streaming from ${widget.station.country}'
                  : 'Streaming Online',
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ),
            if (widget.station.tags.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                'Genres: ${widget.station.tags}',
                style: const TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _togglePlayback,
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              label: Text(_isPlaying ? 'Pause' : 'Play'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../player/player_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const stations = [
    {
      'name': 'Metro FM',
      'url': 'https://ice.za-radiomedia.com/MetroFM.mp3'
    },
    {
      'name': '5FM',
      'url': 'https://ice.za-radiomedia.com/5FM.mp3'
    },
  ];

  @override
  Widget build(BuildContext context) {
    final player = Provider.of<PlayerProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Live Radio')),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: stations.length,
              itemBuilder: (context, index) {
                final station = stations[index];
                return ListTile(
                  title: Text(station['name']!),
                  onTap: () =>
                      player.play(station['name']!, station['url']!),
                );
              },
            ),
          ),
          if (player.currentStation != null)
            Container(
              color: Colors.black87,
              padding: const EdgeInsets.all(12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(player.currentStation!,
                      style: const TextStyle(fontSize: 16)),
                  IconButton(
                    icon: Icon(
                      player.isPlaying ? Icons.pause : Icons.play_arrow,
                    ),
                    onPressed: player.togglePlayPause,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/models/radio_station.dart';
import '../../shared/widgets/station_card.dart';
import '../player/player_screen.dart';
import 'favorites_provider.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favoritesProvider = Provider.of<FavoritesProvider>(context);
    final favorites = favoritesProvider.favorites;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Favorite Stations'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: favorites.isEmpty
          ? const Center(
              child: Text('No favorite stations yet.'),
            )
          : ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final station = favorites[index];
                return StationCard(
                  station: station,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PlayerScreen(station: station),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

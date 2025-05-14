import 'dart:math';
import 'package:flutter/material.dart';
import '../../core/models/radio_station.dart';
import '../../core/services/radio_browser_api.dart';
import '../../shared/widgets/station_card.dart';
import '../player/player_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  final RadioBrowserApi _api = RadioBrowserApi();

  List<RadioStation> _results = [];
  bool _loading = false;
  late String _backgroundImage;

  final List<String> _backgroundImages = [
    'assets/images/search_bg_1.jpg',
    'assets/images/search_bg_2.jpg',
    'assets/images/search_bg_3.jpg',
  ];

  @override
  void initState() {
    super.initState();
    _selectRandomBackground();
  }

  void _selectRandomBackground() {
    final random = Random();
    _backgroundImage = _backgroundImages[random.nextInt(_backgroundImages.length)];
  }

  void _searchStations() async {
    final query = _controller.text.trim();
    if (query.isEmpty) return;

    setState(() {
      _loading = true;
      _results = [];
    });

    try {
      final stations = await _api.searchStations(query);
      setState(() => _results = stations);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.toString()}')),
      );
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Search Radio Stations')),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            _backgroundImage,
            fit: BoxFit.cover,
          ),
          Container(color: Colors.black.withOpacity(0.5)),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(children: [
              TextField(
                controller: _controller,
                style: const TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  labelText: 'Enter station name or frequency (e.g. 947)',
                  border: const OutlineInputBorder(),
                  fillColor: Colors.white,
                  filled: true,
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.search),
                    onPressed: _searchStations,
                  ),
                ),
                onSubmitted: (_) => _searchStations(),
              ),
              const SizedBox(height: 16),
              if (_loading)
                const CircularProgressIndicator()
              else if (_results.isEmpty)
                const Text(
                  'No results found. Try a different name or frequency.',
                  style: TextStyle(color: Colors.white),
                ),
              if (_results.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: _results.length,
                    itemBuilder: (context, index) {
                      final station = _results[index];
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
                ),
            ]),
          ),
        ],
      ),
    );
  }
}

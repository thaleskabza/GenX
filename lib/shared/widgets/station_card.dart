import 'package:flutter/material.dart';
import '../../core/models/radio_station.dart';

class StationCard extends StatelessWidget {
  final RadioStation station;
  final VoidCallback onTap;

  const StationCard({
    super.key,
    required this.station,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: station.logoUrl.isNotEmpty
            ? Image.network(station.logoUrl, width: 50, height: 50, fit: BoxFit.cover)
            : const Icon(Icons.radio, size: 40),
        title: Text(station.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(
          '${station.country}${station.tags.isNotEmpty ? ' • ${station.tags}' : ''}',
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: const Icon(Icons.play_arrow),
        onTap: onTap,
      ),
    );
  }
}

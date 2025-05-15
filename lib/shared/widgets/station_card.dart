import 'package:flutter/material.dart';
import '../../core/models/radio_station.dart';
import '../../config/constants.dart'; // for defaultStationLogo

class StationCard extends StatelessWidget {
  final RadioStation station;
  final VoidCallback onTap;
  final VoidCallback? onDelete; // Optional delete button

  const StationCard({
    super.key,
    required this.station,
    required this.onTap,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final displayLogo = station.logoUrl.isNotEmpty ? station.logoUrl : defaultStationLogo;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Image.network(
            displayLogo,
            width: 50,
            height: 50,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const Icon(Icons.radio, size: 40),
          ),
        ),
        title: Text(
          station.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${station.country}${station.tags.isNotEmpty ? ' • ${station.tags}' : ''}',
          style: const TextStyle(color: Colors.grey),
        ),
        trailing: onDelete == null
            ? const Icon(Icons.play_arrow)
            : IconButton(
                icon: const Icon(Icons.delete, color: Colors.red),
                onPressed: onDelete,
              ),
        onTap: onTap,
      ),
    );
  }
}

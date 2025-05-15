import '/config/constants.dart';
class RadioStation {
  final String name;
  final String streamUrl;
  final String logoUrl;
  final String country;
  final String tags;

  RadioStation({
    required this.name,
    required this.streamUrl,
    required this.logoUrl,
    required this.country,
    required this.tags,
  });

  factory RadioStation.fromJson(Map<String, dynamic> json) {
    final logo = json['favicon'];
    return RadioStation(
      name: json['name'] ?? 'Unknown',
      streamUrl: json['url_resolved'] ?? '',
      logoUrl: (logo == null || logo.isEmpty) ? defaultStationLogo : logo,
      country: json['country'] ?? '',
      tags: json['tags'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'streamUrl': streamUrl,
      'logoUrl': logoUrl,
      'country': country,
      'tags': tags,
    };
  }
}

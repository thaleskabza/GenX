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
    return RadioStation(
      name: json['name'] ?? 'Unknown',
      streamUrl: json['url_resolved'] ?? '',
      logoUrl: json['favicon'] ?? '',
      country: json['country'] ?? '',
      tags: json['tags'] ?? '',
    );
  }
}

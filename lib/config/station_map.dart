import '../core/models/radio_station.dart';

final Map<String, RadioStation> stationMap = {
  "94.7": RadioStation(
    name: "947 Johannesburg",
    streamUrl: "https://live.947.co.za/stream",
    logoUrl: "https://radio-logo.com/947.png",
    country: "South Africa",
    tags: "Hits, Pop, Local"
  ),
  "101.9": RadioStation(
    name: "Metro FM",
    streamUrl: "https://live.metrofm.co.za/stream",
    logoUrl: "https://radio-logo.com/metrofm.png",
    country: "South Africa",
    tags: "Urban, Talk, Adult Contemporary"
  ),
  // Add more stations here
};

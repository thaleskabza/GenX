import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/radio_station.dart';

class RadioBrowserApi {
  static const _baseUrl = 'https://de1.api.radio-browser.info/json';

  Future<List<RadioStation>> searchStations(String keyword) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/stations/search?name=$keyword'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => RadioStation.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load stations');
    }
  }

  Future<List<RadioStation>> stationsByCountry(String country) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/stations/bycountry/$country'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      return data.map((json) => RadioStation.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load stations');
    }
  }

Future<List<String>> fetchCountries() async {
  final response = await http.get(Uri.parse('$_baseUrl/countries'));

  if (response.statusCode == 200) {
    final List<dynamic> data = jsonDecode(response.body);
    final List<String> countries = data
        .map((json) => json['name'] as String?)
        .where((name) => name != null && name.isNotEmpty)
        .cast<String>()
        .toList();

    // Sort alphabetically
    countries.sort((a, b) => a.toLowerCase().compareTo(b.toLowerCase()));

    // Move 'South Africa' to the top if it exists
    if (countries.contains('South Africa')) {
      countries.remove('South Africa');
      countries.insert(0, 'South Africa');
    }

    return countries;
  } else {
    throw Exception('Failed to fetch countries');
  }
}

}

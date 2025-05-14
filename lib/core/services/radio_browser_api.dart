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
}

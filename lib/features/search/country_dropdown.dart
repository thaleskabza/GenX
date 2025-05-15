import 'package:flutter/material.dart';
import '../../core/services/radio_browser_api.dart';

class CountryDropdown extends StatefulWidget {
  final Function(String) onCountrySelected;

  const CountryDropdown({
    super.key,
    required this.onCountrySelected,
  });

  @override
  State<CountryDropdown> createState() => _CountryDropdownState();
}

class _CountryDropdownState extends State<CountryDropdown> {
  final RadioBrowserApi _api = RadioBrowserApi();
  List<String> _countries = [];
  String? _selected;

  @override
  void initState() {
    super.initState();
    _fetchCountries();
  }

  Future<void> _fetchCountries() async {
    try {
      final result = await _api.fetchCountries();
      setState(() {
        _countries = result;
        _selected = result.first;
      });
      widget.onCountrySelected(_selected!);
    } catch (e) {
      // handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: const InputDecoration(
        labelText: 'Filter by Country',
        border: OutlineInputBorder(),
        filled: true,
        fillColor: Colors.white,
      ),
      value: _selected,
      items: _countries
          .map((country) => DropdownMenuItem(value: country, child: Text(country)))
          .toList(),
      onChanged: (value) {
        if (value != null) {
          setState(() => _selected = value);
          widget.onCountrySelected(value);
        }
      },
    );
  }
}

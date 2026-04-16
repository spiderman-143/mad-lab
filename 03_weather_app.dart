import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const WeatherHome(),
    );
  }
}

class WeatherHome extends StatefulWidget {
  const WeatherHome({super.key});

  @override
  State<WeatherHome> createState() => _WeatherHomeState();
}

class _WeatherHomeState extends State<WeatherHome> {
  final cityController = TextEditingController(text: 'Bengaluru');
  String location = '';
  String description = 'Search a city to load weather';
  double? temperature;
  IconData icon = Icons.wb_cloudy;
  bool loading = false;

  Future<void> searchWeather() async {
    setState(() => loading = true);
    try {
      final geo = await http.get(Uri.parse(
          'https://geocoding-api.open-meteo.com/v1/search?name=${Uri.encodeComponent(cityController.text)}&count=1'));
      final geoData = jsonDecode(geo.body) as Map<String, dynamic>;
      final results = geoData['results'] as List<dynamic>;
      final first = results.first as Map<String, dynamic>;
      final lat = first['latitude'];
      final lon = first['longitude'];
      location = '${first['name']}, ${first['country']}';

      final weather = await http.get(Uri.parse(
          'https://api.open-meteo.com/v1/forecast?latitude=$lat&longitude=$lon&current=temperature_2m,weather_code'));
      final weatherData = jsonDecode(weather.body) as Map<String, dynamic>;
      final current = weatherData['current'] as Map<String, dynamic>;
      temperature = (current['temperature_2m'] as num).toDouble();
      final code = current['weather_code'] as int;
      description = _labelForCode(code);
      icon = _iconForCode(code);
    } catch (_) {
      description = 'Unable to fetch weather';
    }
    setState(() => loading = false);
  }

  @override
  void initState() {
    super.initState();
    searchWeather();
  }

  String _labelForCode(int code) {
    if (code == 0) return 'Clear sky';
    if ([1, 2, 3].contains(code)) return 'Partly cloudy';
    if ([45, 48].contains(code)) return 'Foggy';
    if ([51, 53, 55, 61, 63, 65].contains(code)) return 'Rainy';
    if ([71, 73, 75].contains(code)) return 'Snowy';
    if ([95, 96, 99].contains(code)) return 'Thunderstorm';
    return 'Cloudy';
  }

  IconData _iconForCode(int code) {
    if (code == 0) return Icons.sunny;
    if ([1, 2, 3].contains(code)) return Icons.cloud;
    if ([45, 48].contains(code)) return Icons.foggy;
    if ([51, 53, 55, 61, 63, 65].contains(code)) return Icons.grain;
    if ([71, 73, 75].contains(code)) return Icons.ac_unit;
    if ([95, 96, 99].contains(code)) return Icons.thunderstorm;
    return Icons.wb_cloudy;
  }

  @override
  void dispose() {
    cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Weather API App')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: cityController,
                    decoration: const InputDecoration(labelText: 'Location'),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: searchWeather,
                  child: const Text('Get Weather'),
                ),
              ],
            ),
            const SizedBox(height: 24),
            if (loading) const CircularProgressIndicator(),
            if (!loading)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, size: 96, color: Colors.blue),
                      const SizedBox(height: 16),
                      Text(location,
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('${temperature?.toStringAsFixed(1) ?? '--'} °C',
                          style: const TextStyle(fontSize: 42)),
                      const SizedBox(height: 8),
                      Text(description, style: const TextStyle(fontSize: 20)),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

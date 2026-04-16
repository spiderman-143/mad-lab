import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(const NewsReaderApp());

class NewsReaderApp extends StatelessWidget {
  const NewsReaderApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.red),
      home: const NewsReaderHome(),
    );
  }
}

class NewsReaderHome extends StatefulWidget {
  const NewsReaderHome({super.key});

  @override
  State<NewsReaderHome> createState() => _NewsReaderHomeState();
}

class _NewsReaderHomeState extends State<NewsReaderHome> {
  List<dynamic> news = [];
  bool loading = true;

  Future<void> fetchNews() async {
    try {
      final response = await http.get(Uri.parse('https://hn.algolia.com/api/v1/search?query=technology'));
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      news = data['hits'] as List<dynamic>;
    } catch (_) {
      news = [];
    }
    setState(() => loading = false);
  }

  @override
  void initState() {
    super.initState();
    fetchNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News Reader')),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: news.length,
              itemBuilder: (context, index) {
                final item = news[index] as Map<String, dynamic>;
                return Card(
                  child: ListTile(
                    title: Text('${item['title'] ?? 'No title'}'),
                    subtitle: Text('${item['author'] ?? 'Unknown author'}'),
                  ),
                );
              },
            ),
    );
  }
}

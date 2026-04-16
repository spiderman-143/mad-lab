import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const QuoteApp());
}

class QuoteApp extends StatelessWidget {
  const QuoteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const QuoteHome(),
    );
  }
}

class QuoteHome extends StatefulWidget {
  const QuoteHome({super.key});

  @override
  State<QuoteHome> createState() => _QuoteHomeState();
}

class _QuoteHomeState extends State<QuoteHome> {
  String mood = 'Happy';
  String quote = 'Tap the button to get a quote';

  final Map<String, String> prompts = {
    'Happy': 'Keep shining, your energy changes rooms.',
    'Calm': 'Peace is not empty, it is quietly powerful.',
    'Sad': 'Slow progress is still progress, be gentle with yourself.',
    'Motivated': 'Action builds confidence faster than overthinking.',
  };

  Future<void> fetchQuote() async {
    setState(() => quote = 'Loading...');
    try {
      final response =
          await http.get(Uri.parse('https://api.quotable.io/random'));
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      quote = '"${data['content']}"';
    } catch (_) {
      quote = prompts[mood]!;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mood Based Quote Suggestor')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<String>(
              value: mood,
              isExpanded: true,
              items: prompts.keys
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => mood = value!),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [Colors.indigo.shade300, Colors.blue.shade200],
                ),
              ),
              child: Text(
                quote,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w600),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: fetchQuote,
              child: const Text('Suggest Quote Using HTTPS'),
            ),
          ],
        ),
      ),
    );
  }
}

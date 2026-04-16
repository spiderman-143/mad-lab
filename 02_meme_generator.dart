import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MemeApp());
}

class MemeApp extends StatelessWidget {
  const MemeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meme Generator',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepOrange),
      home: const MemeHome(),
    );
  }
}

class MemeHome extends StatefulWidget {
  const MemeHome({super.key});

  @override
  State<MemeHome> createState() => _MemeHomeState();
}

class _MemeHomeState extends State<MemeHome> {
  final topController = TextEditingController();
  final bottomController = TextEditingController();
  String imageUrl = 'https://i.imgflip.com/1bij.jpg';
  bool loading = false;

  Future<void> fetchMeme() async {
    setState(() => loading = true);
    try {
      final response =
          await http.get(Uri.parse('https://api.imgflip.com/get_memes'));
      final data = jsonDecode(response.body) as Map<String, dynamic>;
      final memes = data['data']['memes'] as List<dynamic>;
      memes.shuffle();
      imageUrl = memes.first['url'] as String;
    } catch (_) {}
    setState(() => loading = false);
  }

  @override
  void initState() {
    super.initState();
    fetchMeme();
  }

  @override
  void dispose() {
    topController.dispose();
    bottomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Meme Generator')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: topController,
              decoration: const InputDecoration(labelText: 'Top text'),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: bottomController,
              decoration: const InputDecoration(labelText: 'Bottom text'),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 16),
            AspectRatio(
              aspectRatio: 1,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: loading
                        ? const Center(child: CircularProgressIndicator())
                        : Image.network(imageUrl, fit: BoxFit.cover),
                  ),
                  Positioned(
                    top: 12,
                    left: 12,
                    right: 12,
                    child: MemeText(text: topController.text.toUpperCase()),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    right: 12,
                    child: MemeText(text: bottomController.text.toUpperCase()),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: fetchMeme,
              child: const Text('Fetch Meme Through API'),
            ),
          ],
        ),
      ),
    );
  }
}

class MemeText extends StatelessWidget {
  final String text;

  const MemeText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 26,
        fontWeight: FontWeight.w900,
        shadows: [
          Shadow(color: Colors.black, blurRadius: 6),
          Shadow(color: Colors.black, blurRadius: 12),
        ],
      ),
    );
  }
}

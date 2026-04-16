import 'package:flutter/material.dart';

void main() {
  runApp(const MovieReviewApp());
}

class MovieReviewApp extends StatelessWidget {
  const MovieReviewApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.red),
      home: const MovieReviewHome(),
    );
  }
}

class MovieReviewHome extends StatefulWidget {
  const MovieReviewHome({super.key});

  @override
  State<MovieReviewHome> createState() => _MovieReviewHomeState();
}

class _MovieReviewHomeState extends State<MovieReviewHome> {
  int rating = 0;

  Color get background {
    if (rating >= 4) return Colors.green.shade100;
    if (rating == 3) return Colors.orange.shade100;
    return Colors.red.shade100;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,
      appBar: AppBar(title: const Text('Movie Review App')),
      body: Center(
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  height: 220,
                  width: 160,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    image: const DecorationImage(
                      image: NetworkImage(
                          'https://images.unsplash.com/photo-1489599849927-2ee91cede3ba?w=800'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const Text('Movie Title: Midnight Journey',
                    style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                const Text('Genre: Adventure / Drama'),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    final star = index + 1;
                    return IconButton(
                      onPressed: () => setState(() => rating = star),
                      icon: Icon(
                        star <= rating ? Icons.star : Icons.star_border,
                        color: Colors.amber,
                      ),
                    );
                  }),
                ),
                Text('Rating: $rating',
                    style: const TextStyle(fontSize: 18)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

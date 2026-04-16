import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const ColorMatchApp());
}

class ColorMatchApp extends StatelessWidget {
  const ColorMatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const ColorMatchHome(),
    );
  }
}

class ColorMatchHome extends StatefulWidget {
  const ColorMatchHome({super.key});

  @override
  State<ColorMatchHome> createState() => _ColorMatchHomeState();
}

class _ColorMatchHomeState extends State<ColorMatchHome> {
  final random = Random();
  final List<Color> colors = [
    Colors.red,
    Colors.green,
    Colors.blue,
    Colors.orange,
    Colors.purple,
  ];
  int targetIndex = 0;
  int playerIndex = 1;
  int score = 0;

  void nextRound() {
    setState(() {
      targetIndex = random.nextInt(colors.length);
      playerIndex = random.nextInt(colors.length);
    });
  }

  void cyclePlayerColor() {
    setState(() {
      playerIndex = (playerIndex + 1) % colors.length;
      if (playerIndex == targetIndex) {
        score++;
      }
    });
  }

  @override
  void initState() {
    super.initState();
    nextRound();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gesture Based Color Match Game')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Score: $score',
                style:
                    const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            const Text('Target color',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              curve: Curves.easeInOut,
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                color: colors[targetIndex],
                borderRadius: BorderRadius.circular(24),
              ),
            ),
            const SizedBox(height: 28),
            const Text('Tap the player box until it matches',
                style: TextStyle(fontSize: 18)),
            const SizedBox(height: 12),
            GestureDetector(
              onTap: cyclePlayerColor,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 350),
                curve: Curves.easeInOut,
                height: 140,
                width: 140,
                decoration: BoxDecoration(
                  color: colors[playerIndex],
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: const [
                    BoxShadow(color: Colors.black26, blurRadius: 10)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: nextRound,
              child: const Text('Next Target'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const TapCircleApp());
}

class TapCircleApp extends StatelessWidget {
  const TapCircleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.purple),
      home: const TapCircleHome(),
    );
  }
}

class TapCircleHome extends StatefulWidget {
  const TapCircleHome({super.key});

  @override
  State<TapCircleHome> createState() => _TapCircleHomeState();
}

class _TapCircleHomeState extends State<TapCircleHome> {
  final random = Random();
  Timer? timer;
  int score = 0;
  int timeLeft = 30;
  double left = 100;
  double top = 120;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (timeLeft == 0) {
        timer?.cancel();
      } else {
        setState(() => timeLeft--);
      }
    });
  }

  void moveCircle() {
    setState(() {
      score++;
      left = random.nextDouble() * 250;
      top = random.nextDouble() * 400;
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tap The Circle Game')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text('Score: $score',
                    style:
                        const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text('Timer: $timeLeft',
                    style:
                        const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  left: left,
                  top: top,
                  child: GestureDetector(
                    onTap: timeLeft == 0 ? null : moveCircle,
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        color: Colors.purple,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
                if (timeLeft == 0)
                  const Center(
                    child: Text(
                      'Game Over',
                      style:
                          TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

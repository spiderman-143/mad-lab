import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const CatchBallApp());
}

class CatchBallApp extends StatelessWidget {
  const CatchBallApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      home: const CatchBallHome(),
    );
  }
}

class CatchBallHome extends StatefulWidget {
  const CatchBallHome({super.key});

  @override
  State<CatchBallHome> createState() => _CatchBallHomeState();
}

class _CatchBallHomeState extends State<CatchBallHome> {
  final random = Random();
  Timer? timer;
  double paddleX = 120;
  double ballX = 100;
  double ballY = 0;
  double speed = 6;
  int score = 0;

  @override
  void initState() {
    super.initState();
    startGame();
  }

  void startGame() {
    timer?.cancel();
    ballX = random.nextDouble() * 260;
    ballY = 0;
    timer = Timer.periodic(const Duration(milliseconds: 30), (_) {
      setState(() {
        ballY += speed;
        if (ballY > 420) {
          if ((ballX - paddleX).abs() < 60) {
            score++;
          } else {
            score--;
          }
          ballX = random.nextDouble() * 260;
          ballY = 0;
        }
      });
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
      appBar: AppBar(title: const Text('Catch The Falling Ball')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text('Score: $score',
                    style:
                        const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Slider(
                  value: speed,
                  min: 2,
                  max: 14,
                  label: speed.toStringAsFixed(1),
                  onChanged: (value) => setState(() => speed = value),
                ),
                Text('Adjust speed: ${speed.toStringAsFixed(1)}'),
              ],
            ),
          ),
          Expanded(
            child: GestureDetector(
              onHorizontalDragUpdate: (details) {
                setState(() {
                  paddleX = (paddleX + details.delta.dx).clamp(0, 260);
                });
              },
              child: Center(
                child: Container(
                  width: 320,
                  height: 460,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black26),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        left: ballX,
                        top: ballY,
                        child: Container(
                          width: 28,
                          height: 28,
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 18,
                        left: paddleX,
                        child: Container(
                          width: 80,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

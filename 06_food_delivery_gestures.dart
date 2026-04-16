import 'package:flutter/material.dart';

void main() {
  runApp(const FoodGestureApp());
}

class FoodGestureApp extends StatelessWidget {
  const FoodGestureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.orange),
      home: const FoodGestureHome(),
    );
  }
}

class FoodGestureHome extends StatefulWidget {
  const FoodGestureHome({super.key});

  @override
  State<FoodGestureHome> createState() => _FoodGestureHomeState();
}

class _FoodGestureHomeState extends State<FoodGestureHome> {
  final List<String> status = ['Order placed', 'Cooking', 'On the way', 'Delivered'];
  int step = 0;
  double mapZoom = 1;
  int reorderCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Food Delivery Gestures')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            GestureDetector(
              onDoubleTap: () => setState(() => reorderCount++),
              onLongPress: () => ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Hold detected: opening item details'))),
              onScaleUpdate: (details) =>
                  setState(() => mapZoom = details.scale.clamp(0.8, 2.2)),
              child: AnimatedScale(
                scale: mapZoom,
                duration: const Duration(milliseconds: 150),
                child: Container(
                  height: 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: LinearGradient(
                      colors: [Colors.orange.shade300, Colors.red.shade300],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Pinch / Zoom Map\nDouble tap to reorder\nHold to inspect',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Dismissible(
              key: ValueKey(step),
              direction: DismissDirection.horizontal,
              onDismissed: (_) {
                setState(() => step = (step + 1) % status.length);
              },
              child: Card(
                child: ListTile(
                  leading: const Icon(Icons.delivery_dining),
                  title: const Text('Swipe to see order status'),
                  subtitle: Text('Current status: ${status[step]}'),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text('Reordered with double tap: $reorderCount times',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

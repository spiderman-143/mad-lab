import 'package:flutter/material.dart';

void main() => runApp(const PortfolioUiApp());

class PortfolioUiApp extends StatelessWidget {
  const PortfolioUiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const PortfolioUiHome(),
    );
  }
}

class PortfolioUiHome extends StatelessWidget {
  const PortfolioUiHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Portfolio UI')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CircleAvatar(radius: 42, child: Icon(Icons.person, size: 42)),
            const SizedBox(height: 16),
            const Text('Aman Kumar',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const Text('Flutter Developer'),
            const SizedBox(height: 20),
            const Text('Projects', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            ...['Travel App', 'Recipe Finder', 'Expense Tracker'].map(
              (project) => Card(child: ListTile(title: Text(project))),
            ),
          ],
        ),
      ),
    );
  }
}

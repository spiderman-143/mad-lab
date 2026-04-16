import 'package:flutter/material.dart';

void main() => runApp(const EcommerceUiApp());

class EcommerceUiApp extends StatelessWidget {
  const EcommerceUiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.pink),
      home: const EcommerceUiHome(),
    );
  }
}

class EcommerceUiHome extends StatelessWidget {
  const EcommerceUiHome({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      {'name': 'Sneakers', 'price': '₹2499'},
      {'name': 'Headphones', 'price': '₹1899'},
      {'name': 'Backpack', 'price': '₹1299'},
      {'name': 'Watch', 'price': '₹3299'},
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('E-commerce UI')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Trending Products',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: GridView.builder(
                itemCount: items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final item = items[index];
                  return Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 120, color: Colors.pink.shade100),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(item['name']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                              const SizedBox(height: 6),
                              Text(item['price']!),
                              const SizedBox(height: 8),
                              FilledButton(onPressed: () {}, child: const Text('Add to Cart')),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

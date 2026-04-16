import 'package:flutter/material.dart';

void main() {
  runApp(const TravelEntertainmentApp());
}

class TravelEntertainmentApp extends StatelessWidget {
  const TravelEntertainmentApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Travel and Entertainment',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const TravelEntertainmentHome(),
    );
  }
}

class TravelEntertainmentHome extends StatefulWidget {
  const TravelEntertainmentHome({super.key});

  @override
  State<TravelEntertainmentHome> createState() =>
      _TravelEntertainmentHomeState();
}

class _TravelEntertainmentHomeState extends State<TravelEntertainmentHome> {
  double distance = 120;
  double costPerKm = 12;
  int travellers = 2;
  double rating = 3;
  int currentIndex = 0;

  final List<Map<String, String>> places = const [
    {'title': 'Goa Escape', 'subtitle': 'Beach trip with music nights'},
    {'title': 'Manali Adventure', 'subtitle': 'Snow, treks and cafes'},
    {'title': 'Jaipur Heritage', 'subtitle': 'Palaces and cultural shows'},
  ];

  double get totalCost => (distance * costPerKm) / travellers;

  @override
  Widget build(BuildContext context) {
    final bg = rating >= 4
        ? Colors.green.shade50
        : rating >= 3
            ? Colors.orange.shade50
            : Colors.red.shade50;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(title: const Text('Travel & Entertainment Manager')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Swipe Widget',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 180,
                    child: PageView.builder(
                      itemCount: places.length,
                      onPageChanged: (value) => setState(() {
                        currentIndex = value;
                      }),
                      itemBuilder: (context, index) {
                        final item = places[index];
                        return Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            gradient: LinearGradient(
                              colors: [Colors.teal.shade400, Colors.blue.shade300],
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(item['title']!,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold)),
                                Text(item['subtitle']!,
                                    style: const TextStyle(color: Colors.white)),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text('Current package: ${places[currentIndex]['title']}'),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Travel Cost Calculator',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Slider(
                    value: distance,
                    min: 20,
                    max: 1000,
                    label: '${distance.round()} km',
                    onChanged: (value) => setState(() => distance = value),
                  ),
                  Text('Distance: ${distance.toStringAsFixed(0)} km'),
                  Slider(
                    value: costPerKm,
                    min: 5,
                    max: 30,
                    label: '₹${costPerKm.toStringAsFixed(0)}/km',
                    onChanged: (value) => setState(() => costPerKm = value),
                  ),
                  Text('Cost per km: ₹${costPerKm.toStringAsFixed(2)}'),
                  DropdownButton<int>(
                    value: travellers,
                    isExpanded: true,
                    items: [1, 2, 3, 4, 5, 6]
                        .map((e) =>
                            DropdownMenuItem(value: e, child: Text('$e travellers')))
                        .toList(),
                    onChanged: (value) => setState(() => travellers = value!),
                  ),
                  const SizedBox(height: 8),
                  Text('Estimated cost per person: ₹${totalCost.toStringAsFixed(2)}',
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
            ),
          ),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Movie Rating',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  const Text('Featured movie: The Wanderer'),
                  Row(
                    children: List.generate(5, (index) {
                      final star = index + 1;
                      return IconButton(
                        onPressed: () => setState(() => rating = star.toDouble()),
                        icon: Icon(
                          star <= rating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                        ),
                      );
                    }),
                  ),
                  Text('Current rating: ${rating.toStringAsFixed(0)}/5'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

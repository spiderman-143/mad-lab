import 'package:flutter/material.dart';

void main() => runApp(const HotelUiApp());

class HotelUiApp extends StatelessWidget {
  const HotelUiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const HotelUiHome(),
    );
  }
}

class HotelUiHome extends StatelessWidget {
  const HotelUiHome({super.key});

  @override
  Widget build(BuildContext context) {
    final rooms = ['Deluxe Room', 'Suite Room', 'Executive Room'];
    return Scaffold(
      appBar: AppBar(title: const Text('Hotel Management UI')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Guest Dashboard',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
          const SizedBox(height: 16),
          ...rooms.map((room) => Card(
                child: ListTile(
                  leading: const Icon(Icons.hotel),
                  title: Text(room),
                  subtitle: const Text('Available • Breakfast included'),
                  trailing: FilledButton(onPressed: () {}, child: const Text('Book')),
                ),
              )),
          const SizedBox(height: 20),
          Card(
            child: ListTile(
              leading: const Icon(Icons.room_service),
              title: const Text('Room Service'),
              subtitle: const Text('Laundry, food, cleaning'),
              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ),
        ],
      ),
    );
  }
}

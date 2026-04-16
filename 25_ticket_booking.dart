import 'package:flutter/material.dart';

void main() => runApp(const TicketBookingApp());

class TicketBookingApp extends StatelessWidget {
  const TicketBookingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.red),
      home: const TicketBookingHome(),
    );
  }
}

class TicketBookingHome extends StatefulWidget {
  const TicketBookingHome({super.key});

  @override
  State<TicketBookingHome> createState() => _TicketBookingHomeState();
}

class _TicketBookingHomeState extends State<TicketBookingHome> {
  String movie = 'Avengers';
  int seats = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Ticket Booking')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<String>(
              value: movie,
              isExpanded: true,
              items: const ['Avengers', 'Inception', 'Interstellar']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => movie = value!),
            ),
            const SizedBox(height: 12),
            DropdownButton<int>(
              value: seats,
              isExpanded: true,
              items: [1, 2, 3, 4, 5]
                  .map((e) => DropdownMenuItem(value: e, child: Text('$e seats')))
                  .toList(),
              onChanged: (value) => setState(() => seats = value!),
            ),
            const SizedBox(height: 18),
            Card(
              child: ListTile(
                title: Text(movie),
                subtitle: Text('Seats: $seats'),
                trailing: Text('₹${(seats * 180)}'),
              ),
            ),
            const SizedBox(height: 12),
            FilledButton(onPressed: () {}, child: const Text('Confirm Booking')),
          ],
        ),
      ),
    );
  }
}

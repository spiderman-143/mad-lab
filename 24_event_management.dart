import 'package:flutter/material.dart';

void main() => runApp(const EventManagementApp());

class EventManagementApp extends StatelessWidget {
  const EventManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const EventManagementHome(),
    );
  }
}

class EventManagementHome extends StatefulWidget {
  const EventManagementHome({super.key});

  @override
  State<EventManagementHome> createState() => _EventManagementHomeState();
}

class _EventManagementHomeState extends State<EventManagementHome> {
  final List<String> events = ['Tech Talk', 'Music Night', 'Startup Meetup'];
  final List<String> joined = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Event Management')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          ...events.map((event) => Card(
                child: ListTile(
                  title: Text(event),
                  subtitle: Text(joined.contains(event) ? 'Registered' : 'Open for registration'),
                  trailing: FilledButton(
                    onPressed: () => setState(() => joined.add(event)),
                    child: const Text('Join'),
                  ),
                ),
              )),
          const SizedBox(height: 20),
          Text('Registered count: ${joined.length}',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

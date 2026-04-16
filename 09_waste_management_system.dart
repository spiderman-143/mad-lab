import 'package:flutter/material.dart';

void main() {
  runApp(const WasteApp());
}

class WasteApp extends StatelessWidget {
  const WasteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      home: const WasteHome(),
    );
  }
}

class WasteHome extends StatefulWidget {
  const WasteHome({super.key});

  @override
  State<WasteHome> createState() => _WasteHomeState();
}

class _WasteHomeState extends State<WasteHome> {
  String role = 'Resident';
  String zone = 'Zone A';
  String complaint = '';
  final List<String> notifications = [
    'Special drive: Plastic collection this Saturday',
  ];
  final List<String> complaints = [];
  double duePayment = 320;

  void addNotification(String message) {
    setState(() => notifications.insert(0, message));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Corporate Waste Management')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButton<String>(
            value: role,
            isExpanded: true,
            items: const ['Admin', 'Supervisor', 'Driver', 'Resident']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) => setState(() => role = value!),
          ),
          const SizedBox(height: 12),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Role: $role',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  if (role == 'Supervisor') ...[
                    DropdownButton<String>(
                      value: zone,
                      isExpanded: true,
                      items: const ['Zone A', 'Zone B', 'Zone C']
                          .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                          .toList(),
                      onChanged: (value) => setState(() => zone = value!),
                    ),
                    FilledButton(
                      onPressed: () => addNotification(
                          'Pickup scheduled for $zone on Monday 7:00 AM'),
                      child: const Text('Assign Date And Notify Residents'),
                    ),
                  ],
                  if (role == 'Driver')
                    FilledButton(
                      onPressed: () =>
                          addNotification('Driver alert: Pickup delayed by 30 mins'),
                      child: const Text('Alert Delay In Pickup'),
                    ),
                  if (role == 'Resident') ...[
                    TextField(
                      decoration:
                          const InputDecoration(labelText: 'Post complaint'),
                      onChanged: (value) => complaint = value,
                    ),
                    const SizedBox(height: 8),
                    FilledButton(
                      onPressed: () {
                        if (complaint.trim().isEmpty) return;
                        setState(() => complaints.add(complaint.trim()));
                      },
                      child: const Text('Submit Complaint'),
                    ),
                    const SizedBox(height: 12),
                    Text('Due payment: ₹${duePayment.toStringAsFixed(0)}'),
                    FilledButton(
                      onPressed: () => setState(() => duePayment = 0),
                      child: const Text('Make Payment'),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Text('Notifications',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ...notifications.map((e) => Card(child: ListTile(title: Text(e)))),
          if (complaints.isNotEmpty) ...[
            const SizedBox(height: 16),
            const Text('Complaints',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            ...complaints.map((e) => Card(child: ListTile(title: Text(e)))),
          ],
        ],
      ),
    );
  }
}

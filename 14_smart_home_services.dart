import 'package:flutter/material.dart';

void main() {
  runApp(const SmartHomeApp());
}

class SmartHomeApp extends StatelessWidget {
  const SmartHomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blueGrey),
      home: const SmartHomeHome(),
    );
  }
}

class ServiceItem {
  ServiceItem(this.name, this.price, this.rating);
  final String name;
  final double price;
  final double rating;
}

class SmartHomeHome extends StatefulWidget {
  const SmartHomeHome({super.key});

  @override
  State<SmartHomeHome> createState() => _SmartHomeHomeState();
}

class _SmartHomeHomeState extends State<SmartHomeHome> {
  final services = [
    ServiceItem('Cleaning', 499, 4.8),
    ServiceItem('Plumbing', 699, 4.6),
    ServiceItem('Electrician', 799, 4.7),
    ServiceItem('AC Service', 999, 4.5),
    ServiceItem('Pest Control', 1299, 4.4),
  ];
  final selected = <ServiceItem>[];
  String slot = '10:00 AM';
  String status = 'Pending';

  double get total =>
      selected.fold(0, (sum, item) => sum + item.price);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Smart Home Services')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text('Choose services',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ...services.map((service) => CheckboxListTile(
                value: selected.contains(service),
                title: Text(service.name),
                subtitle: Text(
                    '₹${service.price.toStringAsFixed(0)} • Rating ${service.rating}'),
                onChanged: (value) {
                  setState(() {
                    if (value == true) {
                      selected.add(service);
                    } else {
                      selected.remove(service);
                    }
                  });
                },
              )),
          DropdownButton<String>(
            value: slot,
            isExpanded: true,
            items: const ['10:00 AM', '1:00 PM', '4:00 PM', '7:00 PM']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) => setState(() => slot = value!),
          ),
          const SizedBox(height: 8),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Total cost: ₹${total.toStringAsFixed(0)}',
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold)),
                  Text('Selected slot: $slot'),
                  Text('Dynamic status: $status'),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    children: ['Pending', 'Confirmed', 'Solved']
                        .map((e) => ChoiceChip(
                              label: Text(e),
                              selected: status == e,
                              onSelected: (_) => setState(() => status = e),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 12),
                  FilledButton(
                    onPressed: () {},
                    child: const Text('View Final Orders / Payment'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

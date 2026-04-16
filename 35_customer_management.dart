import 'package:flutter/material.dart';

void main() => runApp(const CustomerManagementApp());

class CustomerManagementApp extends StatelessWidget {
  const CustomerManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const CustomerManagementHome(),
    );
  }
}

class CustomerManagementHome extends StatefulWidget {
  const CustomerManagementHome({super.key});

  @override
  State<CustomerManagementHome> createState() => _CustomerManagementHomeState();
}

class _CustomerManagementHomeState extends State<CustomerManagementHome> {
  final nameController = TextEditingController();
  final contactController = TextEditingController();
  final List<Map<String, String>> customers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Customer Management')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Customer name')),
            const SizedBox(height: 10),
            TextField(controller: contactController, decoration: const InputDecoration(labelText: 'Contact')),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: () {
                if (nameController.text.trim().isEmpty || contactController.text.trim().isEmpty) return;
                setState(() => customers.add({'name': nameController.text.trim(), 'contact': contactController.text.trim()}));
                nameController.clear();
                contactController.clear();
              },
              child: const Text('Add Customer'),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: customers.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.people),
                    title: Text(customers[index]['name']!),
                    subtitle: Text(customers[index]['contact']!),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

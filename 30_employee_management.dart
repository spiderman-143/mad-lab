import 'package:flutter/material.dart';

void main() => runApp(const EmployeeManagementApp());

class EmployeeManagementApp extends StatelessWidget {
  const EmployeeManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.indigo),
      home: const EmployeeManagementHome(),
    );
  }
}

class EmployeeManagementHome extends StatefulWidget {
  const EmployeeManagementHome({super.key});

  @override
  State<EmployeeManagementHome> createState() => _EmployeeManagementHomeState();
}

class _EmployeeManagementHomeState extends State<EmployeeManagementHome> {
  final nameController = TextEditingController();
  final roleController = TextEditingController();
  final List<Map<String, String>> employees = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Employee Management')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Employee name')),
            const SizedBox(height: 10),
            TextField(controller: roleController, decoration: const InputDecoration(labelText: 'Job role')),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: () {
                if (nameController.text.trim().isEmpty || roleController.text.trim().isEmpty) return;
                setState(() => employees.add({'name': nameController.text.trim(), 'role': roleController.text.trim()}));
                nameController.clear();
                roleController.clear();
              },
              child: const Text('Add Employee'),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: employees.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    leading: const CircleAvatar(child: Icon(Icons.person)),
                    title: Text(employees[index]['name']!),
                    subtitle: Text(employees[index]['role']!),
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

import 'package:flutter/material.dart';

void main() => runApp(const StudentManagementApp());

class StudentManagementApp extends StatelessWidget {
  const StudentManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blueGrey),
      home: const StudentManagementHome(),
    );
  }
}

class StudentManagementHome extends StatefulWidget {
  const StudentManagementHome({super.key});

  @override
  State<StudentManagementHome> createState() => _StudentManagementHomeState();
}

class _StudentManagementHomeState extends State<StudentManagementHome> {
  final nameController = TextEditingController();
  final departmentController = TextEditingController();
  final List<Map<String, String>> students = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Management')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(labelText: 'Student name')),
            const SizedBox(height: 10),
            TextField(controller: departmentController, decoration: const InputDecoration(labelText: 'Department')),
            const SizedBox(height: 10),
            FilledButton(
              onPressed: () {
                if (nameController.text.trim().isEmpty || departmentController.text.trim().isEmpty) return;
                setState(() => students.add({
                      'name': nameController.text.trim(),
                      'department': departmentController.text.trim(),
                    }));
                nameController.clear();
                departmentController.clear();
              },
              child: const Text('Add Student'),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    leading: const Icon(Icons.school),
                    title: Text(students[index]['name']!),
                    subtitle: Text(students[index]['department']!),
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

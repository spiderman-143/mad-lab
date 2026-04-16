import 'package:flutter/material.dart';

void main() => runApp(const NotesApp());

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.orange),
      home: const NotesHome(),
    );
  }
}

class NotesHome extends StatefulWidget {
  const NotesHome({super.key});

  @override
  State<NotesHome> createState() => _NotesHomeState();
}

class _NotesHomeState extends State<NotesHome> {
  final controller = TextEditingController();
  final List<String> notes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notes App')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: controller,
              maxLines: 3,
              decoration: const InputDecoration(labelText: 'Write a note'),
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: () {
                if (controller.text.trim().isEmpty) return;
                setState(() => notes.insert(0, controller.text.trim()));
                controller.clear();
              },
              child: const Text('Save Note'),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: notes.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Text(notes[index]),
                    trailing: IconButton(
                      onPressed: () => setState(() => notes.removeAt(index)),
                      icon: const Icon(Icons.delete),
                    ),
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

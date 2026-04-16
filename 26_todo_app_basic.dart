import 'package:flutter/material.dart';

void main() => runApp(const BasicTodoApp());

class BasicTodoApp extends StatelessWidget {
  const BasicTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.cyan),
      home: const BasicTodoHome(),
    );
  }
}

class BasicTodoHome extends StatefulWidget {
  const BasicTodoHome({super.key});

  @override
  State<BasicTodoHome> createState() => _BasicTodoHomeState();
}

class _BasicTodoHomeState extends State<BasicTodoHome> {
  final controller = TextEditingController();
  final List<String> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo App')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(labelText: 'Task'),
                  ),
                ),
                const SizedBox(width: 10),
                FilledButton(
                  onPressed: () {
                    if (controller.text.trim().isEmpty) return;
                    setState(() => todos.add(controller.text.trim()));
                    controller.clear();
                  },
                  child: const Text('Add'),
                )
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Text(todos[index]),
                    trailing: IconButton(
                      onPressed: () => setState(() => todos.removeAt(index)),
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

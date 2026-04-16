import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.cyan),
      home: const TodoHome(),
    );
  }
}

class Task {
  Task(this.title, {this.done = false});
  String title;
  bool done;
}

class TodoHome extends StatefulWidget {
  const TodoHome({super.key});

  @override
  State<TodoHome> createState() => _TodoHomeState();
}

class _TodoHomeState extends State<TodoHome> {
  final controller = TextEditingController();
  final List<Task> tasks = [];

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo Gesture App')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration: const InputDecoration(labelText: 'Enter task'),
                  ),
                ),
                const SizedBox(width: 12),
                FilledButton(
                  onPressed: () {
                    if (controller.text.trim().isEmpty) return;
                    setState(() => tasks.add(Task(controller.text.trim())));
                    controller.clear();
                  },
                  child: const Text('Add'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ReorderableListView.builder(
                itemCount: tasks.length,
                onReorder: (oldIndex, newIndex) {
                  setState(() {
                    if (newIndex > oldIndex) newIndex -= 1;
                    final item = tasks.removeAt(oldIndex);
                    tasks.insert(newIndex, item);
                  });
                },
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Dismissible(
                    key: ValueKey('${task.title}-$index'),
                    onDismissed: (_) => setState(() => tasks.removeAt(index)),
                    child: AnimatedOpacity(
                      key: ValueKey('opacity-$index'),
                      duration: const Duration(milliseconds: 300),
                      opacity: task.done ? 0.35 : 1,
                      child: Card(
                        child: CheckboxListTile(
                          value: task.done,
                          title: Text(
                            task.title,
                            style: TextStyle(
                              decoration: task.done
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          onChanged: (value) =>
                              setState(() => task.done = value ?? false),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

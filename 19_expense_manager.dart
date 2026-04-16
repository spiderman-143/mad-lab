import 'package:flutter/material.dart';

void main() => runApp(const ExpenseManagerApp());

class ExpenseManagerApp extends StatelessWidget {
  const ExpenseManagerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      home: const ExpenseManagerHome(),
    );
  }
}

class Expense {
  Expense(this.title, this.amount, this.category);
  final String title;
  final double amount;
  final String category;
}

class ExpenseManagerHome extends StatefulWidget {
  const ExpenseManagerHome({super.key});

  @override
  State<ExpenseManagerHome> createState() => _ExpenseManagerHomeState();
}

class _ExpenseManagerHomeState extends State<ExpenseManagerHome> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  String category = 'Food';
  final List<Expense> expenses = [];

  double get total => expenses.fold(0, (sum, item) => sum + item.amount);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Expense Manager')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: titleController, decoration: const InputDecoration(labelText: 'Expense title')),
            const SizedBox(height: 10),
            TextField(
              controller: amountController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Amount'),
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: category,
              isExpanded: true,
              items: const ['Food', 'Travel', 'Bills', 'Shopping']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => category = value!),
            ),
            FilledButton(
              onPressed: () {
                final amount = double.tryParse(amountController.text);
                if (titleController.text.trim().isEmpty || amount == null) return;
                setState(() => expenses.add(Expense(titleController.text.trim(), amount, category)));
                titleController.clear();
                amountController.clear();
              },
              child: const Text('Add Expense'),
            ),
            const SizedBox(height: 12),
            Text('Total Spent: ₹${total.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.builder(
                itemCount: expenses.length,
                itemBuilder: (context, index) {
                  final item = expenses[index];
                  return Card(
                    child: ListTile(
                      title: Text(item.title),
                      subtitle: Text(item.category),
                      trailing: Text('₹${item.amount.toStringAsFixed(0)}'),
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

import 'package:flutter/material.dart';

void main() => runApp(const BudgetManagementApp());

class BudgetManagementApp extends StatelessWidget {
  const BudgetManagementApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.green),
      home: const BudgetManagementHome(),
    );
  }
}

class BudgetManagementHome extends StatefulWidget {
  const BudgetManagementHome({super.key});

  @override
  State<BudgetManagementHome> createState() => _BudgetManagementHomeState();
}

class _BudgetManagementHomeState extends State<BudgetManagementHome> {
  final budgetController = TextEditingController(text: '10000');
  final spentController = TextEditingController(text: '3500');

  double get budget => double.tryParse(budgetController.text) ?? 0;
  double get spent => double.tryParse(spentController.text) ?? 0;
  double get balance => budget - spent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Budget Management')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: budgetController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Budget'),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: spentController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Spent'),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text('Budget: ₹${budget.toStringAsFixed(0)}'),
                    Text('Spent: ₹${spent.toStringAsFixed(0)}'),
                    Text('Balance: ₹${balance.toStringAsFixed(0)}',
                        style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

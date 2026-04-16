import 'package:flutter/material.dart';

void main() => runApp(const BasicBmiApp());

class BasicBmiApp extends StatelessWidget {
  const BasicBmiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.blue),
      home: const BasicBmiHome(),
    );
  }
}

class BasicBmiHome extends StatefulWidget {
  const BasicBmiHome({super.key});

  @override
  State<BasicBmiHome> createState() => _BasicBmiHomeState();
}

class _BasicBmiHomeState extends State<BasicBmiHome> {
  final heightController = TextEditingController(text: '170');
  final weightController = TextEditingController(text: '65');
  double bmi = 0;
  String advice = 'Enter values and calculate';

  void calculate() {
    final h = (double.tryParse(heightController.text) ?? 0) / 100;
    final w = double.tryParse(weightController.text) ?? 0;
    if (h <= 0 || w <= 0) return;
    final result = w / (h * h);
    String text;
    if (result < 18.5) {
      text = 'Underweight: improve nutrition and strength training.';
    } else if (result < 25) {
      text = 'Normal: maintain your current healthy routine.';
    } else if (result < 30) {
      text = 'Overweight: add regular activity and balanced meals.';
    } else {
      text = 'Obese: consider a guided health plan.';
    }
    setState(() {
      bmi = result;
      advice = text;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('BMI Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Height (cm)'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Weight (kg)'),
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: calculate, child: const Text('Calculate')),
            const SizedBox(height: 24),
            Text(bmi == 0 ? '--' : bmi.toStringAsFixed(1),
                style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Text(advice, textAlign: TextAlign.center),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const BmiApp());
}

class BmiApp extends StatelessWidget {
  const BmiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.teal),
      home: const BmiHome(),
    );
  }
}

class _BmiData {
  const _BmiData(this.label, this.color, this.icon, this.advice);
  final String label;
  final Color color;
  final IconData icon;
  final String advice;
}

class BmiHome extends StatefulWidget {
  const BmiHome({super.key});

  @override
  State<BmiHome> createState() => _BmiHomeState();
}

class _BmiHomeState extends State<BmiHome> {
  final heightController = TextEditingController(text: '170');
  final weightController = TextEditingController(text: '65');
  double bmi = 0;
  _BmiData data = const _BmiData(
    'Normal',
    Colors.green,
    Icons.favorite,
    'Maintain your balanced routine.',
  );

  void calculate() {
    final heightCm = double.tryParse(heightController.text) ?? 0;
    final weight = double.tryParse(weightController.text) ?? 0;
    final heightM = heightCm / 100;
    if (heightM <= 0) return;
    bmi = weight / (heightM * heightM);
    if (bmi < 18.5) {
      data = const _BmiData(
        'Underweight',
        Colors.orange,
        Icons.monitor_weight,
        'Increase nutritious calorie intake and strength training.',
      );
    } else if (bmi < 25) {
      data = const _BmiData(
        'Normal',
        Colors.green,
        Icons.favorite,
        'Maintain your balanced routine.',
      );
    } else if (bmi < 30) {
      data = const _BmiData(
        'Overweight',
        Colors.deepOrange,
        Icons.fitness_center,
        'Add regular exercise and reduce processed food.',
      );
    } else {
      data = const _BmiData(
        'Obese',
        Colors.red,
        Icons.health_and_safety,
        'Consult a healthcare professional for a guided plan.',
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: data.color.withOpacity(0.12),
      appBar: AppBar(title: const Text('BMI Dashboard')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: heightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Height in cm'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: weightController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Weight in kg'),
            ),
            const SizedBox(height: 16),
            FilledButton(onPressed: calculate, child: const Text('Calculate BMI')),
            const SizedBox(height: 24),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Icon(data.icon, size: 72, color: data.color),
                    const SizedBox(height: 12),
                    Text(
                      bmi == 0 ? '--' : bmi.toStringAsFixed(1),
                      style: const TextStyle(
                          fontSize: 42, fontWeight: FontWeight.bold),
                    ),
                    Text(data.label,
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: data.color)),
                    const SizedBox(height: 8),
                    Text(data.advice, textAlign: TextAlign.center),
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

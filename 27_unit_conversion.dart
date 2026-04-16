import 'package:flutter/material.dart';

void main() => runApp(const UnitConversionApp());

class UnitConversionApp extends StatelessWidget {
  const UnitConversionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.brown),
      home: const UnitConversionHome(),
    );
  }
}

class UnitConversionHome extends StatefulWidget {
  const UnitConversionHome({super.key});

  @override
  State<UnitConversionHome> createState() => _UnitConversionHomeState();
}

class _UnitConversionHomeState extends State<UnitConversionHome> {
  final controller = TextEditingController(text: '1');
  String mode = 'Kilometers to Miles';

  double get result {
    final value = double.tryParse(controller.text) ?? 0;
    switch (mode) {
      case 'Kilometers to Miles':
        return value * 0.621371;
      case 'Celsius to Fahrenheit':
        return (value * 9 / 5) + 32;
      default:
        return value * 1000;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Unit Conversion')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButton<String>(
              value: mode,
              isExpanded: true,
              items: const ['Kilometers to Miles', 'Celsius to Fahrenheit', 'Kg to Grams']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => mode = value!),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Enter value'),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 24),
            Text('Result: ${result.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  runApp(const ElectricityApp());
}

class ElectricityApp extends StatelessWidget {
  const ElectricityApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.amber),
      home: const ElectricityHome(),
    );
  }
}

class ElectricityHome extends StatefulWidget {
  const ElectricityHome({super.key});

  @override
  State<ElectricityHome> createState() => _ElectricityHomeState();
}

class _ElectricityHomeState extends State<ElectricityHome> {
  String appliance = 'Fan';
  double power = 75;
  double usage = 5;
  double days = 30;
  double cost = 8;

  double get energyUsed => (power / 1000) * usage * days;
  double get monthlyBill => energyUsed * cost;
  double get yearlyBill => monthlyBill * 12;

  Color get usageColor {
    if (monthlyBill > 1500) return Colors.red;
    if (monthlyBill > 700) return Colors.orange;
    return Colors.green;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Electricity Bill Calculator')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          DropdownButton<String>(
            value: appliance,
            isExpanded: true,
            items: const ['Fan', 'AC', 'Refrigerator', 'Washing Machine']
                .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                .toList(),
            onChanged: (value) => setState(() => appliance = value!),
          ),
          const SizedBox(height: 8),
          Text('Power: ${power.toStringAsFixed(0)} W'),
          Slider(
            value: power,
            min: 40,
            max: 2000,
            onChanged: (value) => setState(() => power = value),
          ),
          Text('Usage hours/day: ${usage.toStringAsFixed(1)}'),
          Slider(
            value: usage,
            min: 1,
            max: 24,
            onChanged: (value) => setState(() => usage = value),
          ),
          Text('Number of days: ${days.toStringAsFixed(0)}'),
          Slider(
            value: days,
            min: 1,
            max: 31,
            onChanged: (value) => setState(() => days = value),
          ),
          Text('Cost per unit: ₹${cost.toStringAsFixed(2)}'),
          Slider(
            value: cost,
            min: 1,
            max: 20,
            onChanged: (value) => setState(() => cost = value),
          ),
          const SizedBox(height: 16),
          Container(
            height: 26,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: usageColor.withOpacity(0.2),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: (energyUsed / 300).clamp(0.1, 1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: usageColor,
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  Text('Energy used: ${energyUsed.toStringAsFixed(2)} kWh'),
                  Text('Monthly bill: ₹${monthlyBill.toStringAsFixed(2)}'),
                  Text('Yearly projection: ₹${yearlyBill.toStringAsFixed(2)}'),
                  const SizedBox(height: 8),
                  Text(
                    monthlyBill > 1500
                        ? 'High usage'
                        : monthlyBill > 700
                            ? 'Medium usage'
                            : 'Low usage',
                    style: TextStyle(
                        color: usageColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

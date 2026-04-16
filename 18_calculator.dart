import 'package:flutter/material.dart';

void main() => runApp(const CalculatorApp());

class CalculatorApp extends StatelessWidget {
  const CalculatorApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      home: const CalculatorHome(),
    );
  }
}

class CalculatorHome extends StatefulWidget {
  const CalculatorHome({super.key});

  @override
  State<CalculatorHome> createState() => _CalculatorHomeState();
}

class _CalculatorHomeState extends State<CalculatorHome> {
  String expression = '';
  String output = '0';

  void onPress(String value) {
    setState(() {
      if (value == 'C') {
        expression = '';
        output = '0';
      } else if (value == '=') {
        output = _evaluate(expression);
      } else {
        expression += value;
      }
    });
  }

  String _evaluate(String exp) {
    try {
      final parts = exp.split(RegExp(r'([+\-x/])'));
      final operators = RegExp(r'[+\-x/]').allMatches(exp).map((e) => e.group(0)!).toList();
      if (parts.length < 2 || operators.isEmpty) return exp;
      double result = double.parse(parts.first);
      for (var i = 0; i < operators.length; i++) {
        final n = double.parse(parts[i + 1]);
        switch (operators[i]) {
          case '+':
            result += n;
            break;
          case '-':
            result -= n;
            break;
          case 'x':
            result *= n;
            break;
          case '/':
            result /= n;
            break;
        }
      }
      return result.toStringAsFixed(result.truncateToDouble() == result ? 0 : 2);
    } catch (_) {
      return 'Error';
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttons = ['7', '8', '9', '/', '4', '5', '6', 'x', '1', '2', '3', '-', '0', '.', 'C', '+', '='];
    return Scaffold(
      appBar: AppBar(title: const Text('Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.bottomRight,
                padding: const EdgeInsets.all(16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(expression, style: const TextStyle(fontSize: 28)),
                    Text(output, style: const TextStyle(fontSize: 42, fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              itemCount: buttons.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.all(6),
                child: FilledButton(
                  onPressed: () => onPress(buttons[index]),
                  child: Text(buttons[index], style: const TextStyle(fontSize: 22)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

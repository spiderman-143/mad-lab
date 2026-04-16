import 'package:flutter/material.dart';

void main() => runApp(const ShapeDrawingApp());

class ShapeDrawingApp extends StatelessWidget {
  const ShapeDrawingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepOrange),
      home: const ShapeDrawingHome(),
    );
  }
}

class ShapeDrawingHome extends StatefulWidget {
  const ShapeDrawingHome({super.key});

  @override
  State<ShapeDrawingHome> createState() => _ShapeDrawingHomeState();
}

class _ShapeDrawingHomeState extends State<ShapeDrawingHome> {
  String shape = 'Circle';

  @override
  Widget build(BuildContext context) {
    Widget preview;
    if (shape == 'Circle') {
      preview = Container(width: 180, height: 180, decoration: const BoxDecoration(color: Colors.blue, shape: BoxShape.circle));
    } else if (shape == 'Rectangle') {
      preview = Container(width: 220, height: 140, color: Colors.green);
    } else {
      preview = CustomPaint(size: const Size(220, 180), painter: TrianglePainter());
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Shape Drawing')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<String>(
              value: shape,
              items: const ['Circle', 'Rectangle', 'Triangle']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) => setState(() => shape = value!),
            ),
            const SizedBox(height: 30),
            preview,
          ],
        ),
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.orange;
    final path = Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(0, size.height)
      ..lineTo(size.width, size.height)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

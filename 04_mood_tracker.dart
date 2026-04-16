import 'package:flutter/material.dart';

void main() {
  runApp(const MoodTrackerApp());
}

class MoodTrackerApp extends StatelessWidget {
  const MoodTrackerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.pink,
        fontFamily: 'serif',
      ),
      home: const MoodTrackerHome(),
    );
  }
}

class MoodEntry {
  MoodEntry(this.name, this.emoji, this.color, this.score);
  final String name;
  final String emoji;
  final Color color;
  final int score;
}

class MoodTrackerHome extends StatefulWidget {
  const MoodTrackerHome({super.key});

  @override
  State<MoodTrackerHome> createState() => _MoodTrackerHomeState();
}

class _MoodTrackerHomeState extends State<MoodTrackerHome> {
  final List<MoodEntry> moods = [
    MoodEntry('Happy', '😊', Colors.yellow.shade200, 5),
    MoodEntry('Calm', '😌', Colors.blue.shade100, 4),
    MoodEntry('Neutral', '😐', Colors.grey.shade300, 3),
    MoodEntry('Sad', '😔', Colors.indigo.shade100, 2),
    MoodEntry('Angry', '😠', Colors.red.shade200, 1),
  ];

  final List<MoodEntry> week = [];
  int selectedIndex = 0;

  MoodEntry get currentMood => moods[selectedIndex];

  String get prominentMood {
    if (week.isEmpty) return 'No data yet';
    final counts = <String, int>{};
    for (final mood in week) {
      counts[mood.name] = (counts[mood.name] ?? 0) + 1;
    }
    final sorted = counts.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.first.key;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: currentMood.color,
      appBar: AppBar(title: const Text('Mood Tracker')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Today feels like ${currentMood.name}',
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: List.generate(moods.length, (index) {
                final mood = moods[index];
                return GestureDetector(
                  onTap: () => setState(() => selectedIndex = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(index == selectedIndex ? 0.9 : 0.65),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('${mood.emoji} ${mood.name}',
                        style: const TextStyle(fontSize: 20)),
                  ),
                );
              }),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                if (week.length == 7) week.removeAt(0);
                setState(() => week.add(currentMood));
              },
              child: const Text('Add Today To Weekly Analysis'),
            ),
            const SizedBox(height: 16),
            Text('Most prominent mood: $prominentMood',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            const Text('Weekly Analysis',
                style:
                    TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Expanded(
              child: week.isEmpty
                  ? const Center(child: Text('Add moods to see the weekly chart'))
                  : Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: week.asMap().entries.map((entry) {
                        final mood = entry.value;
                        return Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(mood.emoji, style: const TextStyle(fontSize: 20)),
                                const SizedBox(height: 8),
                                Container(
                                  height: 30.0 * mood.score,
                                  decoration: BoxDecoration(
                                    color: mood.color.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text('D${entry.key + 1}'),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

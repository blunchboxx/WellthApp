import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';

class Task {
  final String title;
  final int points;
  final bool completed;
  Task(this.title, this.points, {this.completed = false});
}

class LandingPageScreen extends StatefulWidget {
  const LandingPageScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<LandingPageScreen> {
  // Growable list of tasks
  List<Task> quests = List<Task>.from([
    Task('Walk 10k steps', 5, completed: true),
    Task('Drink 2 liters of water', 3),
    Task('Read for 30 minutes', 4),
  ]);

  Future<void> _invokeQuestEditor(BuildContext context, int index) async {
    final original = quests[index];
    final titleController = TextEditingController(text: original.title);
    final pointsController = TextEditingController(
      text: original.points.toString(),
    );
    bool isCompleted = original.completed;

    final updated = await showDialog<Task>(
      context: context,
      barrierDismissible: true,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx2, dialogSetState) {
          return AlertDialog(
            title: const Text('Edit Quest'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Quest Name'),
                ),
                TextField(
                  controller: pointsController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Points'),
                ),
                Row(
                  children: [
                    const Text('Completed'),
                    Checkbox(
                      value: isCompleted,
                      onChanged: (val) {
                        if (val != null)
                          dialogSetState(() => isCompleted = val);
                      },
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx2),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                onPressed: () {
                  final newTitle = titleController.text;
                  final newPoints =
                      int.tryParse(pointsController.text) ?? original.points;
                  Navigator.pop(
                    ctx2,
                    Task(newTitle, newPoints, completed: isCompleted),
                  );
                },
                child: const Text('Save'),
              ),
            ],
          );
        },
      ),
    );

    if (updated != null) {
      setState(() => quests[index] = updated);
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wellth Dashboard',
      theme: ThemeData(primarySwatch: Colors.teal),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _summonWelcomeBanner(),
                const SizedBox(height: 16),
                _renderProgressDeck(),
                _magicWaveBreak(),
                _displayQuestPanel(),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
        bottomNavigationBar: _navigationCompass(),
      ),
    );
  }

  Widget _summonWelcomeBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Row(
        children: [
          Image.asset('assets/Wellth logo.png', width: 72, height: 72),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Good Morning,\n Yechan(Paul)',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderProgressDeck() {
    const done = 15, total = 25, diff = -10;
    const indicatorRadius = 48.0;
    final indicatorDiameter = indicatorRadius * 2;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFE0F7EF), Color(0xFFD0F2EE)],
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Almost there !',
            style: TextStyle(
              fontSize: 20,
              decoration: TextDecoration.underline,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularPercentIndicator(
                radius: indicatorRadius,
                lineWidth: 6,
                percent: done / total,
                center: Text('$done/$total'),
                progressColor: Colors.green,
                backgroundColor: Colors.white,
                animation: true,
                animationDuration: 800,
              ),
              const SizedBox(width: 16),
              Text(
                "Circle’s daily goal: $diff",
                style: TextStyle(color: diff < 0 ? Colors.red : Colors.black),
              ),
            ],
          ),

          const SizedBox(height: 12),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: indicatorDiameter,
                height: indicatorDiameter,
                child: const Center(
                  child: Text(
                    '2×',
                    style: TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 12, color: Colors.black),
                      children: [
                        const TextSpan(text: 'Health Pts '),
                        TextSpan(
                          text: 'Multiplier',
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '5 more points until 3×',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _magicWaveBreak() {
    return ClipPath(
      clipper: WaveClipperOne(reverse: true),
      child: Container(height: 24, color: Colors.orangeAccent.withOpacity(0.5)),
    );
  }

  Widget _displayQuestPanel() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Daily Tasks:',
            style: TextStyle(
              fontSize: 18,
              decoration: TextDecoration.underline,
            ),
          ),
          const SizedBox(height: 12),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: quests.length,
            itemBuilder: (ctx, idx) {
              final task = quests[idx];
              return Container(
                margin: const EdgeInsets.only(bottom: 8),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: task.completed
                      ? Colors.red.withOpacity(0.1)
                      : Colors.white,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: task.completed ? Colors.red : Colors.grey[300]!,
                  ),
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        task.completed
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: task.completed ? Colors.red : Colors.grey,
                      ),
                      onPressed: () => setState(
                        () => quests[idx] = Task(
                          task.title,
                          task.points,
                          completed: !task.completed,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(child: Text(task.title)),
                    Row(
                      children: [
                        const Icon(Icons.favorite, size: 16, color: Colors.red),
                        const SizedBox(width: 4),
                        Text('+${task.points}'),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, size: 18),
                      onPressed: () => _invokeQuestEditor(ctx, idx),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _navigationCompass() {
    return BottomNavigationBar(
      currentIndex: 2,
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/feed.png')),
          label: 'Feed',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/board_logo.png')),
          label: 'Board',
        ),
        BottomNavigationBarItem(
          icon: ImageIcon(AssetImage('assets/tasks_logo.png')),
          label: 'Add Task',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.rss_feed_outlined),
          label: 'Circles',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.rss_feed_outlined),
          label: 'Profile',
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:intl/intl.dart';

String monthName(int monthNumber) {
  // Creates a dummy date on that month; 'MMMM' gives you full month name.
  return DateFormat.MMMM('en_US').format(DateTime(2021, monthNumber, 1));
}

DateTime now = DateTime.now();
final today = DateTime.now();
final monthday = DateFormat.MMMM().add_d().format(today);

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
      padding: const EdgeInsets.only(left: 16, right: 16, top: 40, bottom: 20),
      child: Row(
        children: [
          Image.asset('assets/wellth logo w_o text.png', width: 100, height: 84),
          const SizedBox(width: 12),
          const Expanded(
            child: Text(
              'Good Morning,\n Yechan(Paul)',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.w500,
                fontFamily: 'Inter',
                height: 1.2,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
    );
  }

  Widget _renderProgressDeck() {
    const done = 15, total = 25, diff =  done-total;
    const indicatorRadius = 48.0;
    final indicatorDiameter = indicatorRadius * 2;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 23),
      padding: const EdgeInsets.only(top: 14, bottom: 28, left: 29, right: 29),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color.fromARGB(100, 81, 238, 173), Color.fromARGB(255, 224, 239, 245)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(blurRadius: 4, color: Colors.black12)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Center(
            child: Text(
              'Almost there !',
              style: TextStyle(
              fontSize: 32,
              fontFamily: 'Inter',
             // decoration: TextDecoration.underline,
              ),
            ),
            
          ),
          const SizedBox(height: 12),
            Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircularPercentIndicator(
              radius: indicatorRadius,
              lineWidth: 8,
              percent: done / total,
              center: Text('$done/$total',
              style: TextStyle(fontSize: 20),),
              progressColor: Color.fromARGB(255, 17, 209, 129),
              backgroundColor: Colors.white,
              animation: true,
              animationDuration: 800,
              ),
              const SizedBox(width: 16),
              Flexible(
              child: RichText(
                text: TextSpan(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 22,
                ),
                children: [
                  const TextSpan(text: "Circle's daily goal: "),
                  TextSpan(
                  text: '$diff XP',
                  style: TextStyle(
                    color: diff < 0 ? Color.fromARGB(255, 169, 57, 74) : Colors.black,
                  ),
                  ),
                ],
                ),
                softWrap: true,
              ),
              ),
            ],
          ),

          const SizedBox(height: 31),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: indicatorDiameter,
                
               child: Column(
                children: [
                  const Text(
                  '2×',
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    height: 1,
                    color: Colors.blue,
                  ),
                  ),
                  Image.asset(
                  'assets/squigally.png',
                  width: 64,
                  height: 14,
                  ),
                ],
                ),
                ),
              const SizedBox(width: 16,),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(fontSize: 22, color: Colors.black),
                      children: [
                        const TextSpan(text: 'Wellth XP '),
                        TextSpan(
                          text: 'Multiplier',
                          style: const TextStyle(color: Colors.blue),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    '+5 XP until 3×',
                    style: TextStyle(fontSize: 13, color: Color.fromARGB(255, 0, 0, 0)),
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
    return Padding(
      padding: const EdgeInsets.only(top:15),
      child: SizedBox(
      height: 73,                  // height of the wave
      width: double.infinity,         // fill the available width
      child: Image.asset(
        'assets/wave.png',            // your pre-cropped wave PNG
        fit: BoxFit.fill,    
             // scale width to fit, preserve aspect
      ),
        ),
    );
  }

  Widget _displayQuestPanel() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          // row for habit daily view controls
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 23),
            child: Row(
               
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Icon button for month view 
                IconButton(
                  icon: 
                  Column( 
                    children: [ 
                      Icon(Icons.calendar_month_outlined,size: 32, weight:1,color: Color.fromRGBO(230, 114, 114, 1),),
                      const Text('View', style: 
                        TextStyle(fontSize: 14, fontFamily:'Inter', fontWeight:FontWeight.w700, color: Color.fromRGBO(230, 114, 114, 1)), 
                          ),]),
                  onPressed: () => _invokeQuestEditor(context, quests.length),
                ),
                const Spacer(),
            
              // left arrow to move one day back
                IconButton(
                  icon: Image.asset('assets/left arrow.png', width: 32, height: 32),
                  onPressed: () {
                    // Handle left arrow action
                  },
                ),
            
              // date: 
              Text(monthday, style: const TextStyle(fontSize: 22, fontFamily: 'Inter', fontWeight: FontWeight.w500),),
            
              // right arrow to move one day forward
                IconButton(
                  icon: Image.asset('assets/right arrow.png', width: 32, height: 32),
                  onPressed: () {
                    // Handle right arrow action
                  },
                ),
            
                const Spacer(),
            
              // Icon button for filtering tasks by category type
                IconButton(
                  icon: const Icon(Icons.filter_list, size: 32, color: Color.fromRGBO(230, 114, 114, 1)),
                  onPressed: () {
                    // Handle filter action
                  },
                ),
            
              ],
            
            
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

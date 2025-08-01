import 'package:flutter/material.dart';
import 'package:wellth_app/pages/circles_members_page.dart';
import 'package:wellth_app/pages/circles_feeds_page.dart';
import 'package:wellth_app/pages/circles_announcement_page.dart';

class CircleDetailScreen extends StatefulWidget {
  final Map<String, dynamic> circle;
  const CircleDetailScreen({Key? key, required this.circle}) : super(key: key);

  @override
  State<CircleDetailScreen> createState() => _CircleDetailScreenState();
}

class _CircleDetailScreenState extends State<CircleDetailScreen> {
  int selectedSegment = 0; // 0=About,1=Feed,2=Mems,3=Settings
  bool isJoined = false;

  final Gradient tabGradient = const LinearGradient(
    colors: [Colors.pinkAccent, Colors.blue],
  );

  @override
  Widget build(BuildContext context) {
    final circle = widget.circle;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () => Navigator.of(context).pop(),
                ),
                Expanded(
                  child: const Text(
                    'About',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
            Center(
              child: Container(
                width: 100,
                height: 4,
                decoration: BoxDecoration(
                  gradient: tabGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // Segmented control
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: List.generate(4, (i) {
                  final labels = ['About', 'Feed', 'Mems', ''];
                  final icons = [null, null, null, Icons.settings];
                  final selected = selectedSegment == i;

                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: i == 0 ? 0 : 8),
                      decoration: BoxDecoration(
                        gradient: selected ? tabGradient : null,
                        color: selected ? null : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (i == 0) {
                            setState(() => selectedSegment = 0);
                          } else if (i == 1) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CircleFeedPage(circle: circle),
                              ),
                            );
                          } else if (i == 2) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    CircleMembersPage(circle: circle),
                              ),
                            );
                          } else {}
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        child: icons[i] == null
                            ? Text(
                                labels[i],
                                style: TextStyle(
                                  color: selected ? Colors.white : Colors.black,
                                ),
                              )
                            : Icon(
                                icons[i],
                                color: selected ? Colors.white : Colors.black,
                              ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const Divider(height: 32),
            ListTile(
              leading: Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(Icons.group, size: 28, color: Colors.grey),
              ),
              title: Text(
                circle['name'] as String,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(circle['subtitle'] as String? ?? ''),
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _infoColumn('Members', '${circle['members']}'),
                      _infoColumn('Created', circle['created'] as String),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const Text(
                    'Admins',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(circle['admins'] as String),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.lightBlue.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            CirclesAnnouncementsPage(circle: circle),
                      ),
                    );
                  },
                  child: const Text(
                    'Announcements',
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            if (!isJoined)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 100),
                child: OutlinedButton(
                  onPressed: () => setState(() => isJoined = true),
                  child: const Text('Join'),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue.shade200,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton(
                        onPressed: null,
                        child: const Text(
                          'Joined',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 100),
                      child: OutlinedButton(
                        onPressed: _showLeaveDialog,
                        child: const Text('Leave'),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 24),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 4,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          currentIndex: 3,
          onTap: (index) {
            switch (index) {
              case 3:
                Navigator.pushReplacementNamed(context, '/Circles');
                break;
              // case 0: Navigator.pushReplacementNamed(context, '/Feed'); break;
              // case 1: Navigator.pushReplacementNamed(context, '/Board'); break;
              // case 2: Navigator.pushReplacementNamed(context, '/AddTask'); break;
              // case 4: Navigator.pushReplacementNamed(context, '/Profile'); break;
            }
          },
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('assets/feed.png', height: 30),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/board_logo.png', height: 30),
              label: 'Board',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/tasks_logo.png', height: 30),
              label: 'Add Task',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/circles.png', height: 30),
              label: 'Circles',
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person, size: 30),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoColumn(String label, String value) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
      const SizedBox(height: 4),
      Text(value),
    ],
  );

  void _showLeaveDialog() {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        content: const Text('Are you sure you want to leave this circle?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              setState(() => isJoined = false);
            },
            child: const Text('Leave'),
          ),
        ],
      ),
    );
  }
}

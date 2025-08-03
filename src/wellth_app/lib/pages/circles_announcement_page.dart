import 'package:flutter/material.dart';
import 'package:wellth_app/pages/circles_new_announcement_page.dart';
import 'package:wellth_app/pages/circles_announcement_detail_page.dart';

class CirclesAnnouncementsPage extends StatelessWidget {
  final Map<String, dynamic> circle;
  const CirclesAnnouncementsPage({Key? key, required this.circle})
    : super(key: key);

  static const Gradient _tabGradient = LinearGradient(
    colors: [Colors.pinkAccent, Colors.blue],
  );

  @override
  Widget build(BuildContext context) {
    final announcements =
        circle['announcements'] as List<Map<String, String>>? ??
        [
          {'title': 'Game A Reminder', 'date': 'April 20'},
          {'title': 'New Guidelines', 'date': 'April 10'},
          {'title': 'Welcome to the Circle', 'date': 'Mar 5'},
        ];

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
                const Expanded(
                  child: Text(
                    'Announcements',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
            Center(
              child: Container(
                width: 320,
                height: 4,
                decoration: BoxDecoration(
                  gradient: _tabGradient,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: announcements.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, i) {
                  final ann = announcements[i];
                  return InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CirclesAnnouncementDetailPage(
                            announcement: {
                              'title': ann['title']!,
                              'date': ann['date']!,
                            },
                          ),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.grey.shade50,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ann['title']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            ann['date']!,
                            style: TextStyle(color: Colors.grey.shade600),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CirclesNewAnnouncementPage(circle: circle),
            ),
          );
        },
        child: const Icon(Icons.add),
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
              case 0:
                Navigator.pushReplacementNamed(context, '/landingPage');
                break;
              case 1:
                Navigator.pushReplacementNamed(context, '/landingPage');
                break;
              case 2:
                Navigator.pushReplacementNamed(context, '/landingPage');
                break;
              case 3:
                Navigator.pushReplacementNamed(context, '/Circles');
                break;
              case 4:
                Navigator.pushReplacementNamed(context, '/userProfile');
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
}

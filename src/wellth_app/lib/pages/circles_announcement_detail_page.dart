import 'package:flutter/material.dart';

class CirclesAnnouncementDetailPage extends StatelessWidget {
  final Map<String, dynamic> announcement;
  const CirclesAnnouncementDetailPage({Key? key, required this.announcement})
    : super(key: key);

  static const Gradient _tabGradient = LinearGradient(
    colors: [Colors.pinkAccent, Colors.blue],
  );

  @override
  Widget build(BuildContext context) {
    final String title = announcement['title'] as String? ?? '';
    final String date = announcement['date'] as String? ?? '';

    final List<String> items = ['Stretching: 5m', 'Warm-up jog: 5m'];

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
                  child: Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  gradient: _tabGradient,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Container(
                  margin: const EdgeInsets.all(2),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade700,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ...items.map(
                        (item) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('• ', style: TextStyle(fontSize: 16)),
                              Expanded(
                                child: Text(
                                  item,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Spacer(),
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
          items: const [
            BottomNavigationBarItem(
              icon: Image(image: AssetImage('assets/feed.png'), height: 30),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: Image(
                image: AssetImage('assets/board_logo.png'),
                height: 30,
              ),
              label: 'Board',
            ),
            BottomNavigationBarItem(
              icon: Image(
                image: AssetImage('assets/tasks_logo.png'),
                height: 30,
              ),
              label: 'Add Task',
            ),
            BottomNavigationBarItem(
              icon: Image(image: AssetImage('assets/circles.png'), height: 30),
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

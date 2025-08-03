// lib/pages/circle_members_page.dart
import 'package:flutter/material.dart';
import 'package:wellth_app/pages/circles_details_page.dart';
import 'package:wellth_app/pages/circles_feeds_page.dart';

class CircleMembersPage extends StatefulWidget {
  final Map<String, dynamic> circle;
  const CircleMembersPage({Key? key, required this.circle}) : super(key: key);

  @override
  State<CircleMembersPage> createState() => _CircleMembersPageState();
}

class _CircleMembersPageState extends State<CircleMembersPage> {
  int selectedSegment = 2; // 0=About,1=Feed,2=Mems,3=Settings
  String _searchQuery = '';

  final Gradient tabGradient = const LinearGradient(
    colors: [Colors.pinkAccent, Colors.blue],
  );

  @override
  Widget build(BuildContext context) {
    final circle = widget.circle;

    final List<Map<String, String>> members =
        circle['membersList'] ??
        [
          {'name': 'Yechan(Paul) Kim', 'role': 'Member', 'date': 'Jul 1, 2025'},
          {'name': 'Person A', 'role': 'Member', 'date': 'Mar 13, 2025'},
          {'name': 'Person B', 'role': 'Admin', 'date': 'Jul 3, 2024'},
          {'name': 'Person C', 'role': 'Member', 'date': 'Jul 1, 2025'},
          {'name': 'Person D', 'role': 'Member', 'date': 'Jul 1, 2025'},
        ];

    final filtered = members.where((m) {
      return m['name']!.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

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
                    'Mems',
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: List.generate(4, (i) {
                  final labels = ['About', 'Feed', 'Mems', ''];
                  final icons = [null, null, null, Icons.settings];
                  final isSel = selectedSegment == i;
                  return Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: i == 0 ? 0 : 8),
                      decoration: BoxDecoration(
                        gradient: isSel ? tabGradient : null,
                        color: isSel ? null : Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: TextButton(
                        onPressed: () {
                          if (i == 0) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    CircleDetailScreen(circle: circle),
                              ),
                            );
                          } else if (i == 1) {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) => CircleFeedPage(circle: circle),
                              ),
                            );
                          } else if (i == 2) {
                          } else {}
                          setState(() => selectedSegment = i);
                        },
                        style: TextButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        child: icons[i] == null
                            ? Text(
                                labels[i],
                                style: TextStyle(
                                  color: isSel ? Colors.white : Colors.black,
                                ),
                              )
                            : Icon(
                                icons[i],
                                color: isSel ? Colors.white : Colors.black,
                              ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            const Divider(height: 32),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(24),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 4,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.search, color: Colors.grey),
                    const SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        decoration: const InputDecoration(
                          hintText: 'Search members',
                          border: InputBorder.none,
                        ),
                        onChanged: (v) => setState(() => _searchQuery = v),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filtered.length,
                separatorBuilder: (_, __) => const Divider(height: 24),
                itemBuilder: (context, idx) {
                  final m = filtered[idx];
                  return Row(
                    children: [
                      const Icon(Icons.person, size: 32),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              m['name']!,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(m['role']!),
                            Text(m['date']!),
                          ],
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
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

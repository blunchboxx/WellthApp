import 'package:flutter/material.dart';
import 'package:wellth_app/pages/circles_details_page.dart';

class CirclesScreen extends StatefulWidget {
  const CirclesScreen({Key? key}) : super(key: key);

  @override
  State<CirclesScreen> createState() => _CirclesScreenState();
}

class _CirclesScreenState extends State<CirclesScreen> {
  int selectedTab = 0; // 0: My Circles, 1: Explore
  int _currentIndex = 3; // BottomNavigationBar highlight

  String _searchQuery = '';

  final List<Map<String, dynamic>> myCircles = [
    {'name': 'Circle A', 'members': 52},
    {'name': 'Circle B', 'members': 13},
    {'name': 'Circle C', 'members': 5},
    {'name': 'Circle D', 'members': 23},
  ];

  final List<Map<String, dynamic>> exploreCircles = List.generate(
    10,
    (i) => {'name': 'Circle ${i + 1}', 'members': 10 + i},
  );

  void _onItemTapped(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final baseList = selectedTab == 0 ? myCircles : exploreCircles;
    final circlesToShow = baseList.where((circle) {
      return circle['name'].toString().toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
    }).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            const Text(
              'Circles',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            // const SizedBox(height: 8),
            Center(
              child: Container(
                width: 100,
                height: 4,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.pinkAccent, Colors.blue],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(2)),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 140,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: selectedTab == 0
                          ? const LinearGradient(
                              colors: [Colors.pinkAccent, Colors.blue],
                            )
                          : null,
                      color: selectedTab == 0 ? null : Colors.white,
                      borderRadius: const BorderRadius.horizontal(
                        left: Radius.circular(8),
                      ),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: TextButton(
                      onPressed: () => setState(() => selectedTab = 0),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(8),
                          ),
                        ),
                      ),
                      child: Text(
                        'My Circles',
                        style: TextStyle(
                          color: selectedTab == 0 ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                SizedBox(
                  width: 140,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: selectedTab == 1
                          ? const LinearGradient(
                              colors: [Colors.pinkAccent, Colors.blue],
                            )
                          : null,
                      color: selectedTab == 1 ? null : Colors.white,
                      borderRadius: const BorderRadius.horizontal(
                        right: Radius.circular(8),
                      ),
                      border: Border.all(color: Colors.grey),
                    ),
                    child: TextButton(
                      onPressed: () => setState(() => selectedTab = 1),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(8),
                          ),
                        ),
                      ),
                      child: Text(
                        'Explore',
                        style: TextStyle(
                          color: selectedTab == 1 ? Colors.white : Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
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
                          hintText: 'Search circles',
                          border: InputBorder.none,
                        ),
                        onChanged: (value) => setState(() {
                          _searchQuery = value;
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: circlesToShow.length,
                separatorBuilder: (_, __) => const Divider(height: 24),
                itemBuilder: (context, index) {
                  final circle = circlesToShow[index];
                  return ListTile(
                    leading: Stack(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.group,
                            size: 28,
                            color: Colors.grey,
                          ),
                        ),
                        const Positioned(
                          top: -4,
                          right: -4,
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.blue,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                    title: Text(circle['name']),
                    subtitle: Text('${circle['members']} members'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CircleDetailScreen(
                            circle: {
                              'name': circle['name'],
                              'subtitle': 'Feel free',
                              'members': circle['members'],
                              'created': '2025-07-23',
                              'admins': 'Yechan(Paul) Kim',
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      // bottomNavigationBar: Container(
      //   decoration: BoxDecoration(
      //     color: Colors.white,
      //     boxShadow: [
      //       BoxShadow(
      //         color: Colors.grey.withOpacity(0.2),
      //         blurRadius: 4,
      //         offset: const Offset(0, -2),
      //       ),
      //     ],
      //   ),
      //   child: BottomNavigationBar(
      //     type: BottomNavigationBarType.fixed,
      //     currentIndex: _currentIndex,
      //     onTap: _onItemTapped,
      //     selectedItemColor: Colors.black,
      //     unselectedItemColor: Colors.grey,
      //     items: const [
      //       BottomNavigationBarItem(icon: Icon(Icons.rss_feed), label: 'Feed'),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.emoji_events),
      //         label: 'Board',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.add_circle),
      //         label: 'Add Task',
      //       ),
      //       BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Circles'),
      //       BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      //     ],
      //   ),
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
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
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

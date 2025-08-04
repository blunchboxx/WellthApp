import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:wellth_app/pages/circles_details_page.dart';
import 'package:wellth_app/circles.dart'; // fetchTop10CircleNamesAndCounts() 정의된 파일

class CirclesScreen extends StatefulWidget {
  const CirclesScreen({Key? key}) : super(key: key);

  @override
  State<CirclesScreen> createState() => _CirclesScreenState();
}

class _CirclesScreenState extends State<CirclesScreen> {
  int selectedTab = 0; // 0: My Circles, 1: Explore
  int _currentIndex = 3;
  String _searchQuery = '';

  final List<Map<String, dynamic>> myCircles = [
    {'name': 'Hard 75 Group', 'members': 52},
    {'name': 'Morning Joggers', 'members': 13},
    {'name': 'Open Mind Happy Life', 'members': 5},
    {'name': 'Meditation Circle', 'members': 23},
    {'name': 'Book Club', 'members': 23},
    {'name': 'Movie Fans', 'members': 23},
    {'name': 'Random Club', 'members': 23},
    {'name': 'Hydration Circle', 'members': 23},
  ];

  late Future<List<Map<String, dynamic>>> _exploreFuture;

  @override
  void initState() {
    super.initState();
    _exploreFuture = serviceCircleExploreFetchTop30Circle();
  }

  void _onNavItemTapped(int index) {
    if (index == _currentIndex) return;
    setState(() => _currentIndex = index);
    switch (index) {
      case 0:
      case 1:
      case 2:
        Navigator.pushReplacementNamed(context, '/landingPage');
        break;
      case 3:
        Navigator.pushReplacementNamed(context, '/Circles');
        break;
      case 4:
        Navigator.pushReplacementNamed(context, '/userProfile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                _buildTabButton('My Circles', 0, left: true),
                const SizedBox(width: 8),
                _buildTabButton('Explore', 1, left: false),
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
                        textInputAction: TextInputAction.search,
                        onChanged: (v) => setState(() => _searchQuery = v),
                        onSubmitted: (v) {
                          setState(() => _searchQuery = v);
                          FocusScope.of(context).unfocus();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),

            Expanded(
              child: selectedTab == 0
                  ? _buildMyCirclesList()
                  : _buildExploreList(),
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
          currentIndex: _currentIndex,
          onTap: _onNavItemTapped,
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
              icon: Icon(Icons.person, size: 30),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String label, int tabIndex, {required bool left}) {
    final isSelected = selectedTab == tabIndex;
    return SizedBox(
      width: 140,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: isSelected
              ? const LinearGradient(colors: [Colors.pinkAccent, Colors.blue])
              : null,
          color: isSelected ? null : Colors.white,
          borderRadius: left
              ? const BorderRadius.horizontal(left: Radius.circular(8))
              : const BorderRadius.horizontal(right: Radius.circular(8)),
          border: Border.all(color: Colors.grey),
        ),
        child: TextButton(
          onPressed: () => setState(() => selectedTab = tabIndex),
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 12),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMyCirclesList() {
    final filtered = myCircles
        .where(
          (c) => c['name'].toLowerCase().contains(_searchQuery.toLowerCase()),
        )
        .toList();
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: filtered.length,
      separatorBuilder: (_, __) => const Divider(height: 24),
      itemBuilder: (ctx, i) {
        final circle = filtered[i];
        return ListTile(
          leading: _buildCircleIcon(),
          title: Text(circle['name']),
          subtitle: Text('${circle['members']} members'),
          trailing: const Icon(Icons.chevron_right),
          onTap: () {
            Navigator.push(
              ctx,
              MaterialPageRoute(
                builder: (_) => CircleDetailScreen(
                  circle: {
                    'name': circle['name'],
                    'subtitle': '${circle['members']} members',
                    'members': circle['members'],
                    'created': DateTime.now().toIso8601String(),
                    'admins': '',
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildExploreList() {
    return FutureBuilder<List<Map<String, dynamic>>>(
      future: _exploreFuture,
      builder: (ctx, snap) {
        if (snap.connectionState != ConnectionState.done) {
          return const Center(child: CircularProgressIndicator());
        }
        final list = snap.data!
            .where(
              (c) =>
                  c['name'].toLowerCase().contains(_searchQuery.toLowerCase()),
            )
            .toList();
        return ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          itemCount: list.length,
          separatorBuilder: (_, __) => const Divider(height: 24),
          itemBuilder: (ctx, i) {
            final item = list[i];
            return ListTile(
              leading: _buildCircleIcon(),
              title: Text(item['name']),
              subtitle: Text('${item['members']} members'),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                ctx,
                MaterialPageRoute(
                  builder: (_) => CircleDetailScreen(circle: item),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildCircleIcon() {
    return Stack(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(8),
          ),
          child: const Icon(Icons.group, size: 28, color: Colors.grey),
        ),
        const Positioned(
          top: -4,
          right: -4,
          child: Icon(Icons.check_circle, color: Colors.blue, size: 20),
        ),
      ],
    );
  }
}

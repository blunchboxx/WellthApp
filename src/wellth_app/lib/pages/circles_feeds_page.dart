import 'package:flutter/material.dart';
import 'package:wellth_app/pages/circles_members_page.dart';
import 'package:wellth_app/pages/circles_details_page.dart';

class CircleFeedPage extends StatefulWidget {
  final Map<String, dynamic> circle;
  const CircleFeedPage({Key? key, required this.circle}) : super(key: key);

  @override
  State<CircleFeedPage> createState() => _CircleFeedPageState();
}

class _CircleFeedPageState extends State<CircleFeedPage> {
  int selectedSegment = 1; // 0=About,1=Feed,2=Mems,3=Settings
  final Gradient tabGradient = const LinearGradient(
    colors: [Colors.pinkAccent, Colors.blue],
  );

  // Dummy post data
  final List<Map<String, dynamic>> posts = [
    {
      'type': 'image',
      'author': 'Yechan(Paul) Kim',
      'time': '2h',
      'imageUrl': 'assets/feed_sample_1.png',
      'text': 'Nice View!',
    },
    {
      'type': 'text',
      'author': 'Yechan(Paul) Kim',
      'time': '4h',
      'text':
          'I drank about 8 cups (64 fl oz) of water today instead of coffee. Please congratulate me!',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final circle = widget.circle;

    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
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
                    'Feed',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),

            // underline
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
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    CircleDetailScreen(circle: circle),
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
                          } else {
                            setState(() => selectedSegment = i);
                          }
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

            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: posts.length,
                separatorBuilder: (_, __) => const SizedBox(height: 24),
                itemBuilder: (context, idx) {
                  final post = posts[idx];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.person, size: 32),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  post['author'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  post['time'],
                                  style: const TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          const Icon(Icons.more_horiz),
                        ],
                      ),

                      const SizedBox(height: 12),

                      if (post['type'] == 'image') ...[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.asset(
                            post['imageUrl'] as String,
                            height: 200,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 8),
                      ],

                      if ((post['text'] as String?)?.isNotEmpty ?? false)
                        Text(
                          post['text'] as String,
                          style: const TextStyle(fontSize: 16),
                        ),

                      const SizedBox(height: 8),

                      // action buttons
                      Row(
                        children: const [
                          Icon(Icons.favorite_border),
                          SizedBox(width: 16),
                          Icon(Icons.bookmark_border),
                        ],
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
}

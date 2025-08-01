import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CirclesNewAnnouncementPage extends StatefulWidget {
  final Map<String, dynamic> circle;
  const CirclesNewAnnouncementPage({Key? key, required this.circle})
    : super(key: key);

  @override
  State<CirclesNewAnnouncementPage> createState() =>
      _CirclesNewAnnouncementPageState();
}

class _CirclesNewAnnouncementPageState
    extends State<CirclesNewAnnouncementPage> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _bodyController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();

  static const Gradient _tabGradient = LinearGradient(
    colors: [Colors.pinkAccent, Colors.blue],
  );

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat.yMMMd().format(DateTime.now());
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    _dateController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now,
      firstDate: now.subtract(const Duration(days: 365)),
      lastDate: now.add(const Duration(days: 365)),
    );
    if (picked != null) {
      _dateController.text = DateFormat.yMMMd().format(picked);
    }
  }

  void _submitAnnouncement() {
    final newAnn = {
      'title': _titleController.text,
      'body': _bodyController.text,
      'date': _dateController.text,
    };
    Navigator.of(context).pop(newAnn);
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
            // AppBar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const Expanded(
                    child: Text(
                      'New Announcement',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            // Underline
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
            const SizedBox(height: 24),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  labelText: 'Title',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _dateController,
                readOnly: true,
                onTap: _pickDate,
                decoration: InputDecoration(
                  labelText: 'Date',
                  suffixIcon: const Icon(Icons.calendar_today),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _bodyController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: 'Body',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: _submitAnnouncement,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'Post Announcement',
                  style: TextStyle(fontSize: 16),
                ),
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

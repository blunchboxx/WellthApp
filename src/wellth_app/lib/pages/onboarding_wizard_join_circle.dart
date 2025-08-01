import 'package:flutter/material.dart';
import 'package:wellth_app/pages/onboarding_wizard_privacy.dart';
import '../circles.dart';

Future<List<Map<String, String>>?> loadCircles() async {
  try {
    final topCircles = await fetchTop10Circles();
    
    for (final c in topCircles) {
      
      print('Circle ID=${c['id']}, name=${c['name']}');
    }
    return topCircles; 
  } catch (e) {
    print('Error loading circlesssss: $e');
  }
}







class OnboardingJoinCircleScreen extends StatefulWidget {

   @override
     _OnboardingJoinCircleScreenState createState() =>
      _OnboardingJoinCircleScreenState();
}

class _OnboardingJoinCircleScreenState
    extends State<OnboardingJoinCircleScreen> {
  late final Future<List<Map<String, String>>?> _circlesFuture;

  final Set<String> _joined = {};
  final Set<String> _loading = {};

  @override
  void initState() {
    super.initState();
    // Kick off the load exactly once:
    _circlesFuture = loadCircles();

  }


    Future<void> _onTap(String id) async {
    setState(() => _loading.add(id));            // start spinner/disable
    if (_joined.contains(id)) {
      await leaveCircle(id);
      setState(() => _joined.remove(id));
    } else {
      await joinCircle(id);
      setState(() => _joined.add(id));
    }
    setState(() => _loading.remove(id));          // stop spinner/enable
  }




  @override
  Widget build(BuildContext context) {
    
    final gradientBlueOrange = const LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromARGB(100, 28, 179, 230),
        Color.fromARGB(100, 54, 121, 232),
        Color.fromARGB(100, 122, 66, 189),
        Color.fromARGB(100, 169, 56, 165),
        Color.fromARGB(100, 221, 57, 116),
        Color.fromARGB(100, 243, 93, 55),
      ],
    );


    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text(
                'Welcome to Wellth',
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 2),
              Container(
                width: 260,
                height: 4,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.pinkAccent, Colors.blue],
                  ),
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                "Let's get your account setup",
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Expanded(
                child: Container(
                  height: 576,
                  decoration: BoxDecoration(
                    gradient: gradientBlueOrange,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(25, 0, 0, 0),
                        blurRadius: 4,
                        offset: Offset(0, 0),
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(2),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: const [
                        BoxShadow(
                          color: Color.fromARGB(25, 0, 0, 0),
                          blurRadius: 4,
                          offset: Offset(0, 0),
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Join or Create a Circle:',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          decoration: InputDecoration(
                            hintText: 'Search for a Circle',
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: FutureBuilder<List<Map<String, String>>?>(
                          future: _circlesFuture,
                          builder: (context, snap) {
                            if (snap.connectionState == ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                            if (snap.hasError) {
                              return Center(
                                  child: Text('Error: ${snap.error}'));
                            }
                            final circles = snap.data;
                            if (circles == null || circles.isEmpty) {
                              return const Center(
                                  child: Text('No circles found.'));
                            }
                            
                            return ListView.builder(
                            itemCount: 8,
                            itemBuilder: (context, index) {
                              final circle = circles[index];
                              final isJoined = _joined.contains(circle['id']);
                              final isLoading = _loading.contains(circle['id']);
                              
                              return Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const CircleAvatar(
                                        radius: 18,
                                        backgroundImage: AssetImage(
                                          'assets/user_avatar.png',
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            //
                                            ShaderMask(
                                              shaderCallback: (bounds) =>
                                                  const LinearGradient(
                                                    colors: [
                                                      Colors.pinkAccent,
                                                      Colors.blue,
                                                    ],
                                                  ).createShader(
                                                    Rect.fromLTWH(
                                                      0,
                                                      0,
                                                      bounds.width,
                                                      bounds.height,
                                                    ),
                                                  ),
                                              blendMode: BlendMode.srcIn,
                                              child: Text(
                                                circle['name']!,
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'members#',
                                              style: const TextStyle(
                                                color: Colors.black54,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      OutlinedButton(
                                       onPressed: isLoading ? null : () => _onTap(circle['id']!),
                                        child: isLoading
                                          ? const SizedBox(
                                              width: 16,
                                              height: 16,
                                              child: CircularProgressIndicator(strokeWidth: 2),
                                            )
                                          : Text(isJoined ? 'Leave' : 'Join'),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                          }
                        )
                        ),
                        const SizedBox(height: 8),
                        Center(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.add_circle_outline),
                            label: const Text('Create a Circle'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFFFFE1DA),
                              foregroundColor: const Color(0xFFF57F61),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.pinkAccent, Colors.blue],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.all(2),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          alignment: Alignment.center,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          child: const Text(
                            'Go back',
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                const OnboardingPrivacyScreen(),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Colors.pinkAccent, Colors.blue],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        child: const Center(
                          child: Text(
                            'Continue',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

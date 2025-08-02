import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {



  //-----------Gradients--------------//
  final gradient = const LinearGradient(
    colors: [Colors.blue, Colors.purple, Colors.orange],
  );

  final gradient2 = const LinearGradient(
    colors: [Color.fromARGB(255, 240, 80, 59), Colors.purple, Color.fromARGB(255, 196, 206, 213)],
  );

  final gradientBlueOrange = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.blue, Colors.purple, Colors.orange],
    //colors: [Colors.pinkAccent, Colors.blue],
    //colors: [Color.fromARGB(255, 28, 179, 230), Color.fromARGB(255,54, 121, 232), Color.fromARGB(255,122, 66, 189),Color.fromARGB(255,169, 56, 165),Color.fromARGB(255,221, 57, 116),Color.fromARGB(255,243, 93, 55)],
  );

  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchCurrentUser();
  }

  Future<void> fetchCurrentUser() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (doc.exists) {
        setState(() {
          userData = doc.data();
        });
      }
    }
  }


  int _currentIndex = 4; // Profile tab index by default
  final List<String> navLabels = ['Feed', 'Board', 'Add Task', 'Circles', 'Profile'];


  final List<String> badgesEarnedCurrUser = [
    'temp',
    'temp',
    'temp',
  ];

  final Map<String, List<String>> circlesJoinedCurrUser = {
    'Fitness': ['Hard 75 Group', 'Morning Joggers'],
    'Wellness': ['Open Mind Happy Life', 'Meditation Circle'],
    'Social': ['Book Club', 'Movie Fans'],
    'Other': ['Random Club', 'Hydration Circle'],
  };


  
  void handleButtonPress(String label) {
    print("Button pressed: $label");
    // Navigate to the corresponding page based on the label
    switch (label) {
      case 'Feed':
        Navigator.pushNamed(context, '/landingPage');
        break;
      case 'Board':
        Navigator.pushNamed(context, '/landingPage');
        break;
      case 'Add Task':
        Navigator.pushNamed(context, '/landingPage');
        break;
      case 'Circles':
        Navigator.pushNamed(context, '/landingPage');
        break;
      case 'Profile':
        // Already on Profile page, no action needed
        break;
      default:
        print("Unknown label: $label");
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    handleButtonPress(navLabels[index]);
  }

  // Completed task - grab off of data base and put into this list
  // For now, this is a placeholder list
  final List<String> completedTasks = [
    "Walk 10k steps",
    "Drink 8 glasses of water",
    "Do something else"
  ];

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return Center(child: Text('User not logged in'));
    }
  
    
    bool isAdmin = userData?['isAdmin']?['booleanValue'] ?? false;

    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              blurRadius: 4,
              offset: Offset(0, -2), // Shadow above the bar
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: const Color.fromARGB(255, 255, 255, 255),
          currentIndex: _currentIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset('assets/feed.png', height: 25),
              label: 'Feed',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/board_logo.png', height: 25),
              label: 'Board',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/tasks_logo.png', height: 25),
              label: 'Add Task',
            ),
            BottomNavigationBarItem(
              icon: Image.asset('assets/circles.png', height: 25),
              label: 'Circles',
            ),
            BottomNavigationBarItem(
              icon: Container(
                width: 26,
                height: 26,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color.fromARGB(255, 0, 0, 0), width: 1), // Outline color & thickness
                  image: DecorationImage(
                    image: AssetImage('assets/geenas-pfp-because-the-profile-looked-ugly.jpeg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error loading profile'));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final userData = snapshot.data!.data() as Map<String, dynamic>?;

          final firstName = userData?['firstName']?.toString().toUpperCase() ?? 'USER';
          final lastName = userData?['lastName']?.toString().toUpperCase() ?? 'NO NAME';

          return Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFAEF2C8), Color(0xFFD3F1F0), Color(0xffffffff)],
                begin: Alignment.topCenter,
                end: Alignment.center,
              ),
            ),
            child: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () {
                              handleButtonPress("Settings Tapped"); // navigate to settings page  
                            },
                            child: Image.asset('assets/settings.png', height: 34),
                          ),
                          
                          if (isAdmin) // Show only if user is admin
                            Row(
                              children: [
                                  Text("Admin", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: const Color.fromARGB(255, 14, 45, 42))),
                                  Image.asset('assets/admin-badge.png', height: 34, width: 34),
                              ],
                            ),
                          
                          GestureDetector(
                            onTap: () async {
                              await FirebaseAuth.instance.signOut(); // Properly sign out the user
                              Navigator.pushReplacementNamed(context, '/login');
                            },
                            child: Icon(Icons.logout, size: 34),
                          )
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Shift "My Wellth" lower
                        Padding(
                          padding: const EdgeInsets.only(top: 90,left: 12), // adjust this value to move it down
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  Text("My Wellth ", style: TextStyle(fontWeight: FontWeight.bold)),
                                  Image.asset('assets/img2-car.png', height: 17),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text("500", style: TextStyle(fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
              
                        // Profile picture
                        GestureDetector(
                          onTap: () {
                            handleButtonPress("Profile Picture Tapped");
                            // You can navigate or show a modal here
                          },
                          child: Container(
                            height: 154,
                            width: 189,
                            margin: const EdgeInsets.only(left: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(34),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color.fromARGB(255, 0, 0, 0).withOpacity(0.35),
                                  blurRadius: 4,
                                  offset: Offset(0, 4),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(34),
                              child: Image.asset('assets/geenas-pfp-because-the-profile-looked-ugly.jpeg', fit: BoxFit.cover),
                            ),
                          ),
                        ),
              
                        GestureDetector(
                          onTap: () {
                            handleButtonPress("Contacts Tapped");
                            // Navigate to contacts/Friends page
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 90,left: 12), // adjust this value to move it down
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    //Text("My Wellth ", style: TextStyle(fontWeight: FontWeight.w600)),
                                    Image.asset('assets/contacts.png', height: 26, width: 23,),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text("Contacts", style: TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
              
                      ],
                    ),
              
                    const SizedBox(height: 16),
                    Padding(
                      
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.white,
                              boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
                            ),
                            padding: const EdgeInsets.all(16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                            
                                //update these values with actual user data
                                StatWidget(label: 'AGE', value: userData?['age'] != null? '${userData!['age']}': '-',),
                                // Vertical line
                                SizedBox(
                                  height: 40,
                                  child: VerticalDivider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                StatWidget(label: 'WEIGHT', value: userData?['weight'] != null? '${userData!['weight']} lbs': '-',),
                                // Vertical line
                                SizedBox(
                                  height: 40,
                                  child: VerticalDivider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                ),
                                StatWidget(label: 'HEIGHT',
                                                value: userData?['heightFeet'] != null && userData?['heightInches'] != null
                                                ? '${userData!['heightFeet']}\' ${userData!['heightInches']}"' 
                                                : '-',
                                ),
              
                              ],
                            ),
                          ),
              
                          Positioned(
                            top: -10, // overlap the top
                            right: -5,
                            child: GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return Dialog(
                                      backgroundColor: Colors.transparent, // transparent so gradient shows
                                      child: Container(
                                        padding: const EdgeInsets.all(24),
                                        decoration: BoxDecoration(
                                          gradient:  LinearGradient(
                                            colors: [Color.fromARGB(255, 174, 242, 200), Color(0xFFD3F1F0)],
                                            begin: Alignment.topCenter,
                                            end: Alignment.bottomCenter,
                                          ), 
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // Close icon top-right
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: GestureDetector(
                                                onTap: () => Navigator.pop(context),
                                                child: const Icon(Icons.close, color: Color.fromARGB(255, 0, 0, 0), size: 28),
                                              ),
                                            ),
                                            const SizedBox(height: 8),
              
                                            Container(
                                              width: double.infinity,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color: const Color.fromARGB(255, 255, 255, 255),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: InkWell(
                                                borderRadius: BorderRadius.circular(12),
                                                onTap: () async {
                                                  Navigator.pop(context);
                                                  final user = FirebaseAuth.instance.currentUser;
                                                  if (user != null) {
                                                    _showUpdateDialog(context, user.uid);
                                                    
                                                  }
                                                },
              
                                                child: const Center(
                                                  child: Text(
                                                    "Update Profile Information",
                                                    style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
              
                                            const SizedBox(height: 16),
              
                                            Container(
                                              width: double.infinity,
                                              height: 50,
                                              decoration: BoxDecoration(
                                                color:  const Color.fromARGB(255, 255, 255, 255),
                                                borderRadius: BorderRadius.circular(12),
                                              ),
                                              child: InkWell(
                                                borderRadius: BorderRadius.circular(12),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                  // do something
                                                },
                                                child: const Center(
                                                  child: Text(
                                                    "Change Profile Picture",
                                                    style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
              
                              child: Image.asset(
                                'assets/edit-button.png',
                                width: 28,
                                height: 28,
                              ),
                            ),
                          ),
                        ],
                      ),
                      
                    ),
                    const SizedBox(height: 10),
              
                    //get user name from database
                    Text(
                      '$firstName $lastName',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.fromLTRB(16.0, 0, 1.0, 0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Recently Earned Badges", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                          ),
                        ),
                        const SizedBox(height: 6),
                        BadgeWidget(badgesEarned: badgesEarnedCurrUser), // Pass the badgesEarnedCurrUser list
                        SizedBox(width: 1),
                        GestureDetector(
                          onTap: () {
                            //  navigate to badges page
                            print("View All Badges tapped");
                          },
                          child: Image.asset(
                            'assets/view-all-badges.png',
                            height: 48,
                            width: 48,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("My Circles", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                    ),
                    const SizedBox(height: 6),
              
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: const Border(
                              top: BorderSide(color: Color.fromARGB(117, 0, 0, 0), width: 1),
                              bottom: BorderSide(color: Color.fromARGB(117, 0, 0, 0), width: 1),
                            ),
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CirclesWidget(circlesByCategory: circlesJoinedCurrUser),
                              ],
                            ),
                          ),
                        ),
                    ),
              
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("Completed Tasks", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Scrollable completed tasks list inside fixed height box
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: completedTasks.length,
                        itemBuilder: (context, index) {
                          return TaskWidget(
                            taskName: completedTasks[index],
                            isChecked: true,
                            onChanged: null, // disables checkbox interaction
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
        }
      ),
    );
  }
}

class StatWidget extends StatelessWidget {
  final String label;
  final String value;

  const StatWidget({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 18)),
      ],
    );
  }
}

class BadgeWidget extends StatelessWidget {
  final List<String> badgesEarned;

  const BadgeWidget({required this.badgesEarned});

  @override
  Widget build(BuildContext context) {
    if (badgesEarned.isEmpty) {
      return Center(
        child: Image.asset(
          'assets/no_badges.png',
          width: 24,
          height: 24,
          fit: BoxFit.cover,
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: badgesEarned.take(2).map((badge) {
        String imagePath = 'assets/$badge-badge.png';

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: Image.asset(
            imagePath,
            width: 45,
            height: 45,
            fit: BoxFit.cover,
          ),
        );
      }).toList(),
    );
  }
}

class CirclesWidget extends StatelessWidget {
  final Map<String, List<String>> circlesByCategory;

  const CirclesWidget({required this.circlesByCategory, Key? key}) : super(key: key);

  Icon _iconForCategory(String category) {
    switch (category.toLowerCase()) {
      case 'fitness':
        return const Icon(Icons.monitor_heart, color: Colors.black);
      case 'wellness':
        return const Icon(Icons.spa, color: Colors.black);
      case 'social':
        return const Icon(Icons.diversity_1, color: Colors.black);
      default:
        return const Icon(Icons.auto_graph, color: Colors.black);
    }
  }

  @override
  Widget build(BuildContext context) {
    final gradient = const LinearGradient(
      colors: [Colors.blue, Colors.purple, Colors.orange],
    );

    // Flatten all circles from all categories into a single list of (category, circleName) pairs
    final allCircles = circlesByCategory.entries
        .expand((entry) => entry.value.map((circleName) => MapEntry(entry.key, circleName)))
        .toList();

    return Row(
      children: allCircles.map((entry) {
        final category = entry.key;
        final circleName = entry.value;

        return Padding(
          padding: const EdgeInsets.only(right: 12),
          child: GestureDetector(
            onTap: () {
              print('Tapped on circle: $circleName in category: $category');
            },
            child: Container(
              padding: const EdgeInsets.all(1),
              width: 109,
              height: 60,
              decoration: BoxDecoration(
                gradient: gradient.withOpacity(0.27),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(9),
                ),
                padding: const EdgeInsets.all(8),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _iconForCategory(category),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        circleName,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}



class TaskWidget extends StatelessWidget {
  final String taskName;
  final bool isChecked;
  final ValueChanged<bool?>? onChanged; // nullable to disable checkbox

  const TaskWidget({
    required this.taskName,
    required this.isChecked,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Container(
        margin: const EdgeInsets.only(bottom: 4),
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.1),

          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.red,
          ),
        ),
        child: Row(
          children: [
          Icon(
                Icons.check_box,
                color: Colors.red,
              ),
            
            const SizedBox(width: 8),
            Expanded(child: Text(taskName)),
            Row(
              children: [
                const Icon(Icons.rocket_launch, size: 16, color: Colors.red),
                const SizedBox(width: 4),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

void _showUpdateDialog(BuildContext context, String uid) {
  final weightController = TextEditingController();
  final heightFeetController = TextEditingController();
  final heightInchesController = TextEditingController();

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255), // transparent so gradient shows
      title: const Text("Update Height & Weight"),
      content: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient:  LinearGradient(
            colors: [Color.fromARGB(255, 174, 242, 200), Color(0xFFD3F1F0)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ), 
          borderRadius: BorderRadius.circular(20),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(
            colorScheme: Theme.of(context).colorScheme.copyWith(
              primary: Colors.teal, // Focused color
            ),
            inputDecorationTheme: const InputDecorationTheme(
              border: UnderlineInputBorder(),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.teal), // Change the focused underline color
              ),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: weightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Weight (lbs)'),
              ),
              TextField(
                controller: heightFeetController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Height (feet)'),
              ),
              TextField(
                controller: heightInchesController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Height (inches)'),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black, // Text color
          ),
          child: const Text("Cancel"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black, // Text color
            backgroundColor: Colors.white, // Optional: change background to white
          ),
          child: const Text("Save"),
          onPressed: () async {
            final weight = int.tryParse(weightController.text);
            final heightFeet = int.tryParse(heightFeetController.text);
            final heightInches = int.tryParse(heightInchesController.text);

            if (weight != null && heightFeet != null && heightInches != null) {
              await FirebaseFirestore.instance.collection('users').doc(uid).update({
                'weight': weight,
                'heightFeet': heightFeet,
                'heightInches': heightInches,
              });
              Navigator.of(context).pop(); // Close the dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated!')),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Please enter valid numbers.')),
              );
            }
          },
        ),
      ],
    ),
  );
}




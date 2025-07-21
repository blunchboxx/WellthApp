// lib/custom_login_page.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wellth_app/components/gradient-button.dart';
import 'package:wellth_app/app.dart';
import 'package:wellth_app/main.dart';
import 'package:wellth_app/auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserInformationPage extends StatefulWidget {
  const UserInformationPage({super.key});

  @override
  State<UserInformationPage> createState() => _UserInformationPage();
}

class _UserInformationPage extends State <UserInformationPage>{

  @override
  void initState() {
    super.initState();
    loadUserData();
  }

  void finishSignUp() async {
    Navigator.pushReplacementNamed(context, '/userProfile');    
  }

  void loadUserData() async { // Loads existing user data from database
    final user = FirebaseAuth.instance.currentUser;
    final doc = await FirebaseFirestore.instance.collection('users').doc(user!.uid).get();

    if (doc.exists) {
      final data = doc.data()!;
      setState(() {
        _firstName.text = data['firstName'] ?? '';
        _lastName.text = data['lastName'] ?? '';
        _userName.text = data['username'] ?? '';
        _bio.text = data['bio'] ?? '';
        // _dateOfBirth.text = data['dateOfBirth'] ?? ''; // If you add DOB later
      });
    }
  }

  //final _auth = AuthService();
  final _firstName = TextEditingController();
  final _lastName    = TextEditingController();
  final _userName = TextEditingController();
  final _bio    = TextEditingController();
  final _dateOfBirth    = TextEditingController();
  //bool _loading    = false;
  String? _error;
  
  @override
  Widget build(BuildContext context) {
    final gradient = const LinearGradient(
      colors: [Colors.blue, Colors.purple, Colors.orange],
    );

    final gradient2 = const LinearGradient(
      colors: [Color.fromARGB(255, 240, 80, 59), Colors.purple, Colors.blue],
    );

    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        body: GestureDetector(
          behavior: HitTestBehavior.translucent, // Use translucent to ensure background taps are detected
          onTap: () {
            // Dismisses the keyboard by removing focus from the current FocusNode
            FocusScope.of(context).unfocus();
          },
      
      child: SafeArea(
      child: SingleChildScrollView(
      padding: EdgeInsets.only(
        top: 24, 
        left: 16, 
        right: 16, 
        bottom: 10
      ),

      
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(top:10),
          child: Column(
            children: [


              // --- Logo ---
          
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 400,
                  height: 220,
                  margin: const EdgeInsets.only(bottom: 22),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                   
                  ),
                  
                    child: Transform.scale(
                      scale: .9,
                      child: Image.asset(
                        'assets/wellthlogo fin.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  
                ),
              ),
              
              Container(
                
                decoration: BoxDecoration(
              
                    gradient: LinearGradient(
                      colors: gradient.colors.map((c) => c.withOpacity(0.79)).toList(),
                      transform: const GradientRotation(1.5708), // 90 degrees in radians
                      stops: gradient.stops,
                    ),
                  borderRadius: BorderRadius.circular(8),
                  
                ), padding: const EdgeInsets.all(1),
                child: Container(
                  width: 327,
                  padding: const EdgeInsets.only(left:22, top:19, right:22, bottom: 0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey.shade300),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(31, 0, 0, 0),
                        blurRadius: 4,
                        offset: Offset(0, 0),
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                
                      // --- Title + gradient underline ---
                      Column(
                        children: [
                            Align(
                            alignment: const Alignment(-0.9, 1),
                            child: Text(
                              'Enter your information',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontFamily: 'Inter',
                                fontSize: 25,
                                fontWeight: FontWeight.w500
                                ),
                            ),
                          ),
                
                          Align(
                            alignment: Alignment(-1.5, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Container(
                                  height: 4,
                                  width: 275,
                                  decoration: BoxDecoration(
                                  gradient: gradient,
                                  borderRadius: BorderRadius.circular(2), 
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 37),
                

                      // --- First field with gradient border ---
                      Align(
                        alignment: Alignment(-0.9, 0),
                        child: Container(
                          height: 35,
                          width: 270,
                          decoration: BoxDecoration(
                            gradient: gradient.withOpacity(0.27),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(1.5), // Border thickness
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: _firstName,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                
                                hintText: 'First Name',
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),

                       // --- Last field with gradient border ---
                      Align(
                        alignment: Alignment(-0.9, 0),
                        child: Container(
                          height: 35,
                          width: 270,
                          decoration: BoxDecoration(
                            gradient: gradient.withOpacity(0.27),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(1.5), // Border thickness
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: _lastName,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                
                                hintText: 'Last Name',
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),

                       // --- Username with gradient border ---
                      Align(
                        alignment: Alignment(-0.9, 0),
                        child: Container(
                          height: 35,
                          width: 270,
                          decoration: BoxDecoration(
                            gradient: gradient.withOpacity(0.27),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(1.5), // Border thickness
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade50,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: TextField(
                              controller: _userName,
                              keyboardType: TextInputType.name,
                              decoration: const InputDecoration(
                                
                                hintText: 'Pick a username',
                                border: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),
                
                      // --- Bio field with gradient border ---
                        Align(
                        alignment: Alignment(-0.9, 0),
                        child: Container(
                          height: 170,
                          width: 270,
                          decoration: BoxDecoration(
                          gradient: gradient.withOpacity(0.27),
                          borderRadius: BorderRadius.circular(12),
                          ),
                          padding: const EdgeInsets.all(1.5), // Border thickness
                          child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            maxLines: null, // Allows unlimited lines
                            keyboardType: TextInputType.multiline,
                            controller: _bio,
                            decoration: const InputDecoration(
                            hintText: 'Tell us about yourself',
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                          ),
                          ),
                        ),
                        ),
                      const SizedBox(height: 26),
                
                      // --- Error message ---
                      if (_error != null) ...[
                        Text(
                          _error!,
                          style: const TextStyle(color: Colors.red),
                        ),
                        const SizedBox(height: 12),
                      ],
                
                      // --- Gradient “Log in” button and Google button in a row ---
                       Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //Flexible(
                          //flex: 7,
                          //child: Align(
                            //alignment: Alignment.center,
                              MyGradientbutton(
                                onPressed: () async {
                                  final user = FirebaseAuth.instance.currentUser;

                                  try {
                                    await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
                                      'firstName': _firstName.text,
                                      'lastName': _lastName.text,
                                      'username': _userName.text,
                                      'bio': _bio.text,
                                      // 'dateOfBirth': _dateOfBirth.text, // Optional
                                    });

                                    finishSignUp();
                                  } catch (e) {
                                    setState(() {
                                      _error = 'Failed to update profile: $e';
                                    });
                                  }
                                },
                                text: 'Finish'
                              ),                     
                      ],
                    ),

          
          
                      const SizedBox(height: 20),

                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
      )
        )
        )
    );
    
  }
}
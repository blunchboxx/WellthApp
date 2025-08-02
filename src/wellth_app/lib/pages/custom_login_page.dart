// lib/custom_login_page.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wellth_app/components/gradient-buttons.dart';
import 'package:wellth_app/app.dart';
import 'package:wellth_app/main.dart';
import 'package:wellth_app/auth/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CustomLoginPage extends StatefulWidget {
  //Geens Modifications

  /// Pass your Google OAuth clientId here.
  /// Added required on tap - geena
  const CustomLoginPage({super.key});
  //final String clientId;

  @override
  State<CustomLoginPage> createState() => _CustomLoginPageState();
}

class _CustomLoginPageState extends State<CustomLoginPage> {
  final _auth = AuthService();
  final _emailCtrl = TextEditingController();
  final _pwCtrl    = TextEditingController();
  bool _loading    = false;
  String? _error;

  bool _checkingUserStatus = true; 

  @override
  void initState() {
    super.initState();

    FirebaseAuth.instance.authStateChanges().listen((User? user) async {
      if (user != null) {
        final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
        if (doc.exists && mounted) {
          Navigator.of(context).pushReplacementNamed('/landingPage');
        }
      } else {
        // User is logged out, remain on login screen
        if (mounted) {
          setState(() {
            _checkingUserStatus = false;
          });
        }
      }
    });
  }



  void _signInWithGoogle() async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    return FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      // Navigate to home page or do something after successful sign-in
      Navigator.of(context).pushNamed('/landingPage');
    }).catchError((error) {
      // Handle error
      displayMessage(error.toString());
    });
    

  }

  //sign in users
    Future<void> signIn() async {
    setState(() => _loading = true);
  
    try {
      await _auth.signInWithEmail(
         _emailCtrl.text.trim(),
         _pwCtrl.text.trim(),
      );

    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw FirebaseAuthException(code: 'no-user', message: 'No user is currently signed in');
    }

    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    final hasCompleted = doc.data()?['hasCompletedOnboarding'] == true;

    if (hasCompleted) {
      Navigator.of(context).pushReplacementNamed('/userProfile');
    } else {
      Navigator.of(context).pushReplacementNamed('/userInformation');
    }
  } on FirebaseAuthException catch (e) {
    setState(() => _error = e.message);
  } finally {
    if (mounted) setState(() => _loading = false);
    }
  }

// display dialog message
void displayMessage (String message){
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(message),
    ),
  );
}

  @override
  Widget build(BuildContext context) {

    // Is user already logged in? 
    if (_checkingUserStatus) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }


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
                              'Sign in',
                              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                                fontFamily: 'Inter',
                                fontSize: 32,
                                fontWeight: FontWeight.w500
                                ),
                            ),
                          ),
                
                          Align(
                            alignment: Alignment(-0.9, 0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 4),
                                Container(
                                  height: 4,
                                  width: 146,
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
                

                      // --- Email field with gradient border ---
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
                              controller: _emailCtrl,
                              keyboardType: TextInputType.emailAddress,
                              decoration: const InputDecoration(
                                
                                hintText: 'Username or Email',
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
                
                      // --- Password field with gradient border ---
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
                            controller: _pwCtrl,
                            obscureText: true,
                            decoration: const InputDecoration(
                            hintText: 'Password',
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
                        
                        children: [
                        SizedBox(
                        width: 96, // Set your desired width
                        height: 29,  // Set your desired height
                        child: DecoratedBox(
                          decoration: BoxDecoration(
                          gradient: gradient2,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: const [
                            BoxShadow(
                            color: Color.fromARGB(72, 0, 0, 0),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            ),
                          ],
                          ),
                          child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            foregroundColor: Colors.white, 
                            textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Inter',
                            shadows: <Shadow>[
                              Shadow(
                              offset: Offset(0, 2),
                              blurRadius: 5.0,
                              color: const Color.fromARGB(90, 0, 0, 0), 
                              ),
                            ],
                            ),
                            shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            ),
                            padding: EdgeInsets.zero, // Remove default padding
                          ),
                          onPressed: _loading ? null : signIn,
                          child: _loading
                            ? const SizedBox(
                              height: 1,
                              //width: 1,
                              child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Log in'),
                          ),
                        ),
                        ),
          
                        SizedBox(
                          width: 9, // Space between buttons
                        ), 
                        Container(
                          width: 1,
                          height: 28,
                          color: Color.fromARGB(59, 127, 111, 111),
                        ),
          
                        
          
                       
                        
                        ElevatedButton.icon(
                        icon: Image.asset(
                          'assets/google_logo.png',
                          height: 32.38,
                          width: 32.38,
                        ),
          
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          foregroundColor: Colors.transparent, 
                          padding: EdgeInsets.zero, 
                        ),
                        label: const Text(''),
                        onPressed: _loading ? null : _signInWithGoogle,
                        ),
                        ],
                      ),
          
          
                      const SizedBox(height: 20),
                      const Divider(),
                      const SizedBox(height: 0),
                

                      // --- Footer link ---
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'New member?  ',
                            style: TextStyle(
                              color: Color.fromARGB(145, 0, 0, 0),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
          
                          Padding(
                            padding: const EdgeInsets.only(top: 9, bottom: 8), // to align with the text baseline
                            child:Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                
                                
                                
                                TextButton(
                                  onPressed: () => Navigator.of(context).pushNamed('/register'),
                                  style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    visualDensity: VisualDensity.compact,  // removes default button padding
                                  ),
                                  child: const Text(
                                    'Create an account',
                                    style: TextStyle(
                                      color: Color.fromARGB(145, 0, 0, 0),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
          
                                Transform.translate(
                                  offset: const Offset(0, -2), 
                                  child: Container(
                                    height: 2,       
                                    width: 125,      
                                    decoration: BoxDecoration(
                                      gradient: gradient2.withOpacity(0.42),
                                      borderRadius: BorderRadius.circular(1),
                                    ),
                                  ),
                                ),
                              ],
                            ),
          
                          ),
                        ],
                      ),
          
                    
                    
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
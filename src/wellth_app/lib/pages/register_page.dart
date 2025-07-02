// lib/custom_login_page.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wellth_app/components/gradient-button.dart';
import 'package:wellth_app/main.dart';
import 'package:wellth_app/pages/custom_login_page.dart';
import 'package:wellth_app/auth/auth.dart';


class RegisterPage extends StatefulWidget{
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State <RegisterPage>{
    final _auth = AuthService();
  final _emailCtrl             = TextEditingController();
  final _pwCtrl                = TextEditingController();
  final _pwCtrlConfirmation    = TextEditingController();
  final _usernameCtr           = TextEditingController();
  bool _loading    = false;
  String? _error;

  //sign up users
  void signUp() async {
    // show laoding circle
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),),
    );

    //Make sure passwords match
    if(_pwCtrl.text.trim().isEmpty || _pwCtrlConfirmation.text.trim().isEmpty){
      //pop loading cirlce
      if (context.mounted) Navigator.pop(context);
      //show error to user
      displayMessage("Please enter a password");
      return;
    }
    if(_pwCtrl.text != _pwCtrlConfirmation.text){
      //pop loading cirlce
      if (context.mounted) Navigator.pop(context);
      //show error to user
      displayMessage("Passwords don't match");
      return;
    }

  setState(() {
    _loading = true;
    _error = null;
  });

  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailCtrl.text.trim(),
      password: _pwCtrl.text.trim(),

    );
    // pop loading circle
    if (mounted) Navigator.of(context).pop();

    // Navigate to user information page
    Navigator.pushReplacementNamed(context,'/userInformation');

  } on FirebaseAuthException catch (e) {
    if (mounted) Navigator.of(context).pop();
    displayMessage(e.message ?? e.code);
  }
  // …
}

void signUpWithGoogle() async {
  // show laoding circle
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),),
  );
  try {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      // The user canceled the sign-in
      return;
    }

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // Sign in with Firebase using the Google credentials
    await FirebaseAuth.instance.signInWithCredential(credential);

    // pop loading circle
    if (mounted) Navigator.of(context).pop();

    // Navigate to user information page
    Navigator.pushReplacementNamed(context, '/userInformation');

  } catch (error) {
    // Handle error
    displayMessage(error.toString());
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
    final gradient = const LinearGradient(
      colors: [Colors.blue, Colors.purple, Colors.orange],
    );

    final gradient2 = const LinearGradient(
      colors: [Color.fromARGB(255, 240, 80, 59), Colors.purple, Colors.blue],
    );

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- Logo ---

            Align(
              alignment: Alignment.center,
              child: Container(
                width: 400,
                height: 220,
                margin: const EdgeInsets.only(bottom: 10),
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
              
              width: 360,
              height: 390,
              padding: const EdgeInsets.all(1),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: gradient.colors.map((c) => c.withOpacity(0.79)).toList(),
                  transform: const GradientRotation(1.5708), // 90 degrees in radians
                  stops: gradient.stops,
                ),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Container(
                width: 355,
                height: 495,
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
                    //const SizedBox(height: 24),
                
                    // --- Title + gradient underline ---
                    Column(
                      children: [
                          Align(
                          alignment: const Alignment(-0.9, 1),
                          child: Text(
                            'Register your Account',
                            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontFamily: 'Inter',
                              fontSize: 28,
                              fontWeight: FontWeight.w500,
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
                                width: 318,
                                decoration: BoxDecoration(
                                gradient: gradient,
                                borderRadius: BorderRadius.circular(2), // Add this line to round the edges
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                
                    // --- Email field with gradient border ---
                    Align(
                      alignment: Alignment(-0.9, 0),
                      child: Container(
                        height: 38,
                        width: 270,
                        decoration: BoxDecoration(
                          gradient: gradient.withOpacity(0.27),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(2), // Border thickness
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _emailCtrl,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                
                    // --- Password field with gradient border ---
                      Align(
                      alignment: Alignment(-0.9, 0),
                      child: Container(
                        height: 38,
                        width: 270,
                        decoration: BoxDecoration(
                        gradient: gradient.withOpacity(0.27),
                        borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(2), // Border thickness
                        child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TextField(
                          controller: _pwCtrl,
                          obscureText: true,
                          decoration: const InputDecoration(
                          hintText: 'Create Password',
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                        ),
                        ),
                      ),
                      ),
                    const SizedBox(height: 24),
                
                    //-------Confirm Passwrd -----//
                      Align(
                      alignment: Alignment(-0.9, 0),
                      child: Container(
                        height: 38,
                        width: 270,
                        decoration: BoxDecoration(
                          gradient: gradient.withOpacity(0.27),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(2), // Border thickness
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _pwCtrlConfirmation,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: 'Confirm Password',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                
                    // --- Username field with gradient border ---
                    /*Align(
                      alignment: Alignment(-0.9, 0),
                      child: Container(
                        height: 38,
                        width: 270,
                        decoration: BoxDecoration(
                          gradient: gradient.withOpacity(0.27),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(2), // Border thickness
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.shade50,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _usernameCtr,
                            keyboardType: TextInputType.name,
                            decoration: const InputDecoration(
                              hintText: 'Username',
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            ),
                          ),
                        ),
                      ),
                    ),*/
                    //
                
                    // --- Error message ---
                    if (_error != null) ...[
                      Text(
                        _error!,
                        style: const TextStyle(color: Colors.red),
                      ),
                      const SizedBox(height: 12),
                    ],
                
                    // --- Gradient “Sign Up” button ---
                
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        //Flexible(
                          //flex: 7,
                          //child: Align(
                            //alignment: Alignment.center,
                            MyGradientbutton(
                              onPressed: ()
                              {
                                
                                signUp();
 
                                // Navigate to the home page after successful sign-up
                                //Navigator.pushNamed(context, '/home');
                                


                              } , 
                              text: 'Sign Up'
                            ),

                            SizedBox(
                            width: 9, // Space between buttons
                            ), 
                            Container(
                              width: 1,
                              height: 28,
                              color: Color.fromARGB(59, 127, 111, 111),
                            ),
                          //)
                          
                        //),
                        //const SizedBox(width: 16,),

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
                        onPressed: _loading ? null : signUpWithGoogle,
                        ),

                        /*Flexible(
                          // --- Google Sign‐up button ---
                          flex: 8,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: IconButton(
                            icon: Image.asset(
                              'assets/google_logo.png',
                              height: 32.38,
                              width: 32.38,
                            ),
                            onPressed: (){
                              onPressed: _loading ? null : signUpWithGoogle,
                            },
                          ),
                          ),
                          
                          
                          /*ElevatedButton.icon(
                            /*icon: Image.asset(
                              'assets/google.png',
                              height: 50,
                              width: 50,
                            ),*/
                            label: const Text('Sign Up with Google',style: const TextStyle(color: Colors.black)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black87,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                            ),
                            onPressed: null,
                          ),
                
                          const SizedBox(height: 24),
                          const Divider(),
                          const SizedBox(height: 8), */
                        ),*/
                      ],
                    ),
                    const SizedBox(height: 16),

                    //const SizedBox(height:0 ),
                    const Divider(),
                    //const SizedBox(height: 9),
                
                    // --- Footer link ---
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Already a member?   ' ,
                          style: const TextStyle(
                            color: Color.fromARGB(145, 0, 0, 0),
                            fontWeight: FontWeight.w500,
                          )
                        ),
                        TextButton(
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/login'); // Navigate to login page
                                  },
                          
                         style: TextButton.styleFrom(
                                    padding: EdgeInsets.zero,
                                    minimumSize: Size.zero,
                                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                    visualDensity: VisualDensity.compact,  // removes default button padding
                                  ),
                                  child: const Text(
                                    'Log in',
                                    style: TextStyle(
                                      color: Color.fromARGB(145, 0, 0, 0),
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )
                        
                    )],
                    ),
                    Transform.translate(
                      offset: const Offset(72, -1.2), 
                      child: Container(
                        height: 2,       
                        width: 46,      
                        decoration: BoxDecoration(
                          gradient: gradient2.withOpacity(0.42),
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )
    
    );
    
  }
}


  
// lib/custom_login_page.dart

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:wellth_app/components/gradient-button.dart';


class RegisterPage extends StatefulWidget{
  final Function()? onTap;
  const RegisterPage({required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State <RegisterPage>{

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
    if (context.mounted) Navigator.pop(context);
  } on FirebaseAuthException catch (e) {
    // pop loading circle
    if (context.mounted) Navigator.pop(context);
    displayMessage(e.code);
    if (!mounted) return;
    setState(() {
      _error = e.message;
    });
  } finally {
    if (!mounted) return;
    setState(() {
      _loading = false;
    });
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
                    scale: 1.0,
                    child: Image.asset(
                      'assets/wellthlogo fin.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                
              ),
            ),
            
            Container(
              width: 360,
              height: 500,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.grey.shade300),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(0, 4),
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
                            fontSize: 30,
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
                  ),
                  const SizedBox(height: 24),

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      //Flexible(
                        //flex: 7,
                        //child: Align(
                          //alignment: Alignment.center,
                          MyGradientbutton(
                            onTap: signUp, 
                            text: 'Sign Up'
                          ),
                        //)
                        
                      //),
                      //const SizedBox(width: 16,),
                      Flexible(
                        // --- Google Sign‐up button ---
                        flex: 8,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                          icon: Image.asset(
                            'assets/google.png',
                            height: 24,
                            width: 24,
                          ),
                          onPressed: (){
                            print('Google Icone button pressed');
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
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),

                  // --- Footer link ---
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Already a member?'),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(' Login now',style: const TextStyle(color: Colors.blue)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    
    );
    
  }
}


  
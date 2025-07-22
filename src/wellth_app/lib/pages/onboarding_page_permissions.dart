import 'dart:ffi';
import 'package:wellth_app/pages/register_page.dart';
import 'package:wellth_app/pages/onboarding_page_bio.dart';
import 'package:carousel_slider/carousel_slider.dart';

import 'package:flutter/material.dart';

class OnboardingScreen_permissions extends StatefulWidget {
  
  const OnboardingScreen_permissions({super.key});

  @override
  State<OnboardingScreen_permissions> createState() => _OnboardingScreen_permissions();
}

class _OnboardingScreen_permissions extends State<OnboardingScreen_permissions>{

  final _formKey = GlobalKey<FormState>();
  bool _locationGranted = false;
  bool _contactGranted = false;


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
    colors: [Color.fromARGB(255, 28, 179, 230), Color.fromARGB(255,54, 121, 232), Color.fromARGB(255,122, 66, 189),Color.fromARGB(255,169, 56, 165),Color.fromARGB(255,221, 57, 116),Color.fromARGB(255,243, 93, 55)],
  );

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              //---------------Main Screen Text ----------------------------//
              Text("Welcome to Wellth",
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Inter',
                  )
              ),

              //--------------------Gradient Line---------------------------//
              Align(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4,),
                    Container(
                      height: 4,
                      width: 338,
                      decoration: BoxDecoration(
                        gradient: gradient,
                        borderRadius: BorderRadius.circular(2)
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 5),

              //--------------------- Main Screen Subtext ------------------------//
              Text("Let's get your account setup!",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                )
              ),

              SizedBox(height: 40),

              //--------------------- Styled Container with Gradient ----------------------//
              Container(
                height:576,
                decoration: BoxDecoration(
                  gradient: gradientBlueOrange,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: const [
                    BoxShadow(
                      color: Color.fromARGB(25,0,0,0),
                      blurRadius: 4,
                      offset: Offset(0, 0),
                      spreadRadius: 1,
                    ),
                  ],
                ),
                
                padding: EdgeInsets.all(2),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Color.fromARGB(25,0,0,0),
                        blurRadius: 4,
                        offset: Offset(0, 0),
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(10),

                  //---------------------Information inside the Gradient Box ----------------------//
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //---------------------Permissions with underline ----------------------//                         
                        Text("Permissions", 
                          style: TextStyle(
                            fontSize: 36, 
                            fontWeight: FontWeight.w500, 
                            fontFamily: 'Inter',
                            decoration: TextDecoration.underline
                          )
                        ),

                        //-----Space----//
                        SizedBox(height: 16),

                        Center(
                          child: Image.asset(
                            'assets/onboarding-permissions.png',
                            height: 201,
                            fit: BoxFit.cover,
                          ),
                        ),

                          SizedBox(height: 16),

                        Text(
                          'Wellth uses your Location & Contacts for circle recommendations',
                          style: TextStyle(
                            fontSize: 15.0,
                            fontFamily: 'Inter',
                            color: Color.fromRGBO(100, 89, 89, 60),
                          ),
                        ),

                        SizedBox(height: 16),

                        buildPermissionBox(
                          value: _locationGranted,
                          onChanged: (val) {
                            setState(() {
                              _locationGranted = val ?? false;
                            });
                          },
                          iconChecked: Image.asset('assets/location-permission-accepted.png', height: 40),
                          iconUnchecked: Image.asset('assets/location-permission-icon.png', height: 40),
                          text: "Allow Location Access",
                          gradientColors: [
                            Color.fromRGBO(244, 67, 54, 0.27),
                            Color.fromRGBO(156, 39, 176, .27),
                            Color.fromRGBO(33, 150, 243, .27),
                          ],
                        ),

                        SizedBox(height: 16),

                        buildPermissionBox(
                          value: _contactGranted,
                          onChanged: (val) {
                            setState(() {
                              _contactGranted = val ?? false;
                            });
                          },
                          iconChecked: Image.asset('assets/contacts-permission-accepted.png', height: 40,),
                          iconUnchecked: Image.asset('assets/contacts-permission-icon.png', height: 40,),
                          text: "Allow Contact Access",
                          gradientColors: [const Color.fromRGBO( 244, 67, 54, 0.27), const Color.fromRGBO(156, 39, 176, .27), const Color.fromRGBO(33, 150, 243, .27)],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),

              Row(
                children: [
                  Expanded(child: _buildButtonWhite("Go back", () {
                    if (_formKey.currentState!.validate()) {
                      // Go Back to register
                      //Navigator.of(context).pushNamed('/register');

                      Navigator.of(context).push(
                        PageRouteBuilder(
                          settings: RouteSettings(name: '/userInformation'), // So it still integrates with named routes
                          pageBuilder: (context, animation, secondaryAnimation) => OnboardingScreen_bio(),
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(-1.0, 0.0); // ← Slide in from left
                            const end = Offset.zero;
                            const curve = Curves.easeInOut;

                            final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    }
                  })),
                  SizedBox(width: 10),
                  Expanded(child: _buildButtonGradient("Continue", () {

                    if (_formKey.currentState!.validate()) {
                      // Go to next page of onboarding wizard
                      Navigator.of(context).pushNamed('/informationCarousel');
                    }
                  })),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }


  //--------------- Geena's Button Design ---------------//

  /*Widget _buildButtonGradient(String text, VoidCallback onPressed) {
    return SizedBox(
      width: 169,
      height: 41,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              Colors.blue,
              Color.fromARGB(238, 54, 122, 232),
              Color.fromARGB(231, 98, 24, 203),
              Colors.purple,
              Color.fromARGB(211, 222, 57, 115),
              Color.fromARGB(202, 255, 99, 71),
            ],
          ),
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
            padding: EdgeInsets.zero, // Use zero if you're wrapping in SizedBox
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontSize: 25.0,
              fontFamily: 'Inter',
              color: Colors.white,
              shadows: [
                Shadow(offset: Offset(-1.0, -1), color: Color.fromARGB(72, 0, 0, 0)),
                Shadow(offset: Offset(1, -1), color: Color.fromARGB(72, 0, 0, 0)),
                Shadow(offset: Offset(1, 3.5), color: Color.fromARGB(72, 0, 0, 0)),
                Shadow(offset: Offset(-1, 3.5), color: Color.fromARGB(72, 0, 0, 0)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonWhite(String text, VoidCallback onPressed) {
    return SizedBox(
      width: 169,
      height: 41,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.centerRight,
            end: Alignment.centerLeft,
            colors: [
              Colors.blue.withOpacity(0.25),
              Color.fromARGB(238, 54, 122, 232).withOpacity(0.25),
              Color.fromARGB(231, 98, 24, 203).withOpacity(0.25),
              Colors.purple.withOpacity(0.25),
              Color.fromARGB(211, 222, 57, 115).withOpacity(0.25),
              Color.fromARGB(202, 255, 99, 71).withOpacity(0.25),
            ],
          ),
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
              BoxShadow(
                color: Color.fromARGB(72, 0, 0, 0),
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
        ),
        padding: EdgeInsets.all(3), 
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shadowColor: Colors.transparent,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: onPressed,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: 'Inter',
                  color: Color.fromRGBO(100, 89, 89, 100),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }*/

  Widget buildPermissionBox({
    required bool value,
    required Function(bool?) onChanged,
    required Widget iconChecked,
    required Widget iconUnchecked,
    required String text,
    required List<Color> gradientColors,
  }) {
  return Container(
    margin: EdgeInsets.symmetric(vertical: 8),
    padding: EdgeInsets.all(2), // for gradient border effect
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: gradientColors),
      borderRadius: BorderRadius.circular(12),
    ),
    child: GestureDetector(
      onTap: () => onChanged(!value),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white, // inner background
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Center(
                child: gradientText(
                  text,
                  LinearGradient(
                    colors: [
                      const Color.fromRGBO(244, 67, 54, 0.75),
                      const Color.fromRGBO(156, 39, 176, .75),
                      const Color.fromRGBO(33, 150, 243, .75)
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(width: 12),
            value ? iconChecked : iconUnchecked,
          ],
        ),
      ),
    ),
  );
}

  Widget gradientText(String text, Gradient gradient) {
    return ShaderMask(
      shaderCallback: (bounds) => gradient.createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

    //------------ Yechan's Button Design ----------------//
  Widget _buildButtonGradient(String text, VoidCallback onPressed) {
    return SizedBox(
      width: 169,
      height: 41,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pinkAccent, Colors.blue],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            padding: EdgeInsets.zero, // Use zero if you're wrapping in SizedBox
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildButtonWhite(String text, VoidCallback onPressed) {
    return SizedBox(
      width: 169,
      height: 41,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.pinkAccent, Colors.blue],
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: EdgeInsets.all(2), 
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(6),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              shadowColor: Colors.transparent,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: onPressed,
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

}
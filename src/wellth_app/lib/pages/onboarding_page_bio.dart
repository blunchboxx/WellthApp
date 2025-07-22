import 'dart:ffi';
import 'package:wellth_app/pages/register_page.dart';

import 'package:flutter/material.dart';

class OnboardingScreen_bio extends StatefulWidget {
  
  const OnboardingScreen_bio({super.key});

  @override
  State<OnboardingScreen_bio> createState() => _OnboardingScreen_bio();
}

class _OnboardingScreen_bio extends State<OnboardingScreen_bio>{

  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightController = TextEditingController();

  bool validateOnContinue = false;

  String? selectedAge;
  String? selectedGoal;

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

                          //---------------------Bio with underline ----------------------//                         
                          Text("Bio", 
                            style: TextStyle(
                              fontSize: 36, 
                              fontWeight: FontWeight.w500, 
                              fontFamily: 'Inter',
                              decoration: TextDecoration.underline
                            )
                          ),

                          SizedBox(height: 16),

                          //--------pfp-----------//
                          Text("Profile Image:", 
                            style: TextStyle(
                              fontSize: 20, 
                              fontWeight: FontWeight.w500, 
                              fontFamily: 'Inter',
                            )
                          ),
                          Row(
                            children: [
                              //------Column contains pfp + age -----///
                              Column(
                                children: [
                                  //SizedBox(height: 5),
                                  Stack(
                                    alignment: Alignment.bottomRight,
                                    children: [
                                      GestureDetector(
                                        onTap: (){
                                          //------Add upload PfP function-----------//
                                          print("Add pfp Tapped");
                                        },

                                        child: Image.asset(
                                          'assets/onboarding-add-pfp.png',
                                          height: 115,
                                          fit: BoxFit.cover,
                                        ),

                                        //-----circle avatar -----//

                                        /*child: CircleAvatar(
                                          radius: 51.5,
                                          backgroundImage: AssetImage('assets/onboarding-add-pfp.png'),
                                        ),*/
                                        
                                      ),
                                      Container(
                                        width: 24,
                                        height: 24,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Colors.white,
                                        ),
                                        child: Image.asset(
                                          'assets/image-icon.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),

                                    ],
                                  ),
                                  
                                ],
                              ),
                              SizedBox(width: 15),
                              Expanded(child: Column(
                                children: [
                                  SizedBox(height: 10),
                                  //Row 1
                                  _buildTextField("First Name *", firstNameController),

                                  SizedBox(height: 10),

                                  //Row 2
                                  _buildTextField("Last Name *", lastNameController),
                                ],
                              ))
                            ],
                          ),
                          SizedBox(height: 30),

                          Row(
                            children: [
                              //-----Age----/
                              Expanded(child:_buildDropdown("Age *",
                                List<String>.generate(69, (index) => (index + 12).toString()),
                                selectedAge,
                                (value) {
                                  setState(() {
                                    selectedAge = value;
                                  });
                                },
                              )),

                              SizedBox(width: 10),
                              Expanded(child: _buildTextField("Phone Number *", phoneController)),

                            ],
                          ),

                          SizedBox(height: 30),
                          
                          //------------Add more Categories-----------//
                          _buildDropdown("What do you want to use Wellth for? *", [
                            "Fitness",
                            "Nutrition",
                            "Mindfulness",
                            ],
                            selectedGoal,
                            (value) {
                              setState(() {
                                selectedGoal = value;
                              });
                            },
                          ),

                          SizedBox(height: 20),
                          Center(child: Text("Optional", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold))),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(child: _buildTextField("Height", heightController)),
                              SizedBox(width: 10),
                              Expanded(child: _buildTextField("Weight", weightController)),
                            ],
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
                    validateOnContinue = false;
                    if (_formKey.currentState!.validate()) {
                      // Go Back to register
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          settings: RouteSettings(name: '/register'), // So it still integrates with named routes
                          pageBuilder: (context, animation, secondaryAnimation) => RegisterPage(), 
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            const begin = Offset(-1.0, 0.0); // Slide in from left
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
                    validateOnContinue = true;
                    if (_formKey.currentState!.validate()) {
                      // Go to next page of onboarding wizard
                      Navigator.of(context).pushNamed('/userPermission');
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

  Widget _buildTextField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        isDense: true,
      ),
      validator: (value) {
        if (label.contains('*') && (value == null || value.isEmpty) && validateOnContinue) {
          return 'Required';
        }
        return null;
      },
    );
  }

  Widget _buildDropdown(String label, List<String> items, String? selectedValue, Function(String?) onChanged) {
    return DropdownButtonFormField<String>(
      value: selectedValue,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
        isDense: true,
      ),
      items: items
          .map((e) => DropdownMenuItem<String>(
                child: Text(e),
                value: e,
              ))
          .toList(),
      onChanged: onChanged,
      validator: (value) {
        if (label.contains('*') && value == null && validateOnContinue) {
          return 'Required';
        }
        return null;
      },
    );
  }


  Widget _buildButtonGradient(String text, VoidCallback onPressed) {
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
  }
}
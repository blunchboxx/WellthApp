import 'dart:ffi';
import 'package:wellth_app/pages/register_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  final TextEditingController weightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  
  final TextEditingController feetController = TextEditingController();
  final TextEditingController inchesController = TextEditingController();

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
    colors: [Colors.pinkAccent, Colors.blue],
    //colors: [Color.fromARGB(255, 28, 179, 230), Color.fromARGB(255,54, 121, 232), Color.fromARGB(255,122, 66, 189),Color.fromARGB(255,169, 56, 165),Color.fromARGB(255,221, 57, 116),Color.fromARGB(255,243, 93, 55)],
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
                                          height: 150,
                                          fit: BoxFit.cover,
                                        ),

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
                                  _buildTextField("First Name *", firstNameController, TextInputType.name),

                                  SizedBox(height: 10),

                                  //Row 2
                                  _buildTextField("Last Name *", lastNameController, TextInputType.name),
                                ],
                              ))
                            ],
                          ),
                          SizedBox(height: 30),

                          Row(
                            children: [
                              //-----Age----/
                              Expanded(child: _buildTextField("Age *", ageController, TextInputType.number)),

                              SizedBox(width: 10),
                              Expanded(child: _buildTextField("Phone Number *", phoneController, TextInputType.phone)),

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

                          //Text("Height"),
                          //SizedBox(height: 10),
                          Row(
                            children: [
                              //Expanded(child: _buildTextField("Height (e.g. 5'8\")", heightController),),
                              Expanded(
                                child: _buildHeightField(),
                              ),

                              SizedBox(width: 10),
                              Expanded(child: _buildTextField("Weight", weightController, TextInputType.number)),
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

                  Expanded(
                    child: _buildButtonGradient("Continue", () async {
                      validateOnContinue = true;

                      if (_formKey.currentState!.validate()) {
                        try {
                          // Assuming you're using Firebase Auth to get the current user
                          final uid = FirebaseAuth.instance.currentUser?.uid;

                          if (uid == null) {
                            throw Exception('User not logged in');
                          }

                          // Create user data map
                          final userData = {
                            'firstName': firstNameController.text.trim(),
                            'lastName': lastNameController.text.trim(),
                            'phone': phoneController.text.trim(),
                            'weight': weightController.text.trim(),
                            'age': ageController.text.trim(),
                            'heightFeet': feetController.text.trim(),
                            'heightInches': inchesController.text.trim(),
                          };

                          // Save to Firestore under the 'users' collection
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(uid)
                              .set(userData, SetOptions(merge: true));

                          // Navigate after storing data
                          Navigator.of(context).pushNamed('/userPermission');
                        } catch (e) {
                          // Handle errors (e.g., show SnackBar or dialog)
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: ${e.toString()}')),
                          );
                        }
                      }
                    }),
                  ),

                  /*Expanded(child: _buildButtonGradient("Continue", () {
                    validateOnContinue = true;
                    if (_formKey.currentState!.validate()) {
                      // Go to next page of onboarding wizard
                      Navigator.of(context).pushNamed('/userPermission');
                    }
                  })),*/
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, TextInputType type) {
    bool isRequired = label.contains('*');
    String cleanLabel = label.replaceAll('*', '').trim();


    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 6.0, bottom: 4.0),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.black87,
              ),
              children: [
                TextSpan(text: cleanLabel),
                if (isRequired)
                  TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        ),
        Container(
          height: 45,
          width: 270,
          decoration: BoxDecoration(
            gradient: gradient.withOpacity(0.27),
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.all(2),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextFormField(
              controller: controller,
              keyboardType: type,
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
              style: TextStyle(fontSize: 14),
              validator: (value) {
                if (isRequired &&
                    (value == null || value.isEmpty) &&
                    validateOnContinue) {
                  return 'Required';
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }


  Widget _buildDropdown(
    String label,
    List<String> items,
    String? selectedValue,
    Function(String?) onChanged,
  ) {
    bool isRequired = label.contains('*');
    String cleanLabel = label.replaceAll('*', '').trim();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 6.0, bottom: 4.0),
          child: RichText(
            text: TextSpan(
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.black87,
              ),
              children: [
                TextSpan(text: cleanLabel),
                if (isRequired)
                  TextSpan(
                    text: ' *',
                    style: TextStyle(color: Colors.red),
                  ),
              ],
            ),
          ),
        ),
        Row(
          children: [
            Expanded(
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  gradient: gradient.withOpacity(0.27),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(2),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: DropdownButtonFormField<String>(
                    value: selectedValue,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      isDense: true,
                    ),
                    icon: const Icon(Icons.arrow_drop_down),
                    items: items
                        .map(
                          (e) => DropdownMenuItem<String>(
                            value: e,
                            child: Text(e),
                          ),
                        )
                        .toList(),
                    onChanged: onChanged,
                    validator: (value) {
                      if (isRequired && value == null && validateOnContinue) {
                        return 'Required';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
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

  Widget _buildHeightField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 6.0, bottom: 4.0),
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 13,
                color: Colors.black87,
              ),
              children: [
                TextSpan(text: 'Height'),
              ],
            ),
          ),
        ),
        Row(
          children: [
            // Feet
            Expanded(
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  gradient: gradient.withOpacity(0.27),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(2),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextFormField(
                    controller: feetController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'ft',
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    style: TextStyle(fontSize: 14),
                    validator: (value) {
                      final feet = int.tryParse(value ?? '');
                      if ((value?.isNotEmpty ?? false) && (feet == null || feet < 0 || feet > 8)) {
                        return '0–8';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),

            // Inches
            Expanded(
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  gradient: gradient.withOpacity(0.27),
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.all(2),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextFormField(
                    controller: inchesController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: 'in',
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                    ),
                    style: TextStyle(fontSize: 14),
                    validator: (value) {
                      final inches = int.tryParse(value ?? '');
                      if ((value?.isNotEmpty ?? false) && (inches == null || inches < 0 || inches > 11)) {
                        return '0–11';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }


}
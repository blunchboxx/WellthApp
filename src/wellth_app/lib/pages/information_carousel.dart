/*import 'package:flutter/material.dart';
import 'package:wellth_app/pages/onboarding_page_permissions.dart';


class GradientPageSlider extends StatefulWidget {
  @override
  _GradientPageSliderState createState() => _GradientPageSliderState();
}

class _GradientPageSliderState extends State<GradientPageSlider> {
  int _currentIndex = 0;

    //-----------Gradients--------------//
  final gradient = const LinearGradient(
    colors: [Colors.blue, Colors.purple, Colors.orange],
  );

  final gradientBlueOrange = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.pinkAccent, Colors.blue],
    //colors: [Color.fromARGB(255, 28, 179, 230), Color.fromARGB(255,54, 121, 232), Color.fromARGB(255,122, 66, 189),Color.fromARGB(255,169, 56, 165),Color.fromARGB(255,221, 57, 116),Color.fromARGB(255,243, 93, 55)],
  );

  final List<Widget> _carouselPages = [

    // Page 0
    Column(
      key: ValueKey(0),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Circles:", style: TextStyle(
                            fontSize: 36, 
                            fontWeight: FontWeight.w500, 
                            fontFamily: 'Inter',
                            decoration: TextDecoration.underline
                          )),
        SizedBox(height: 16),
        Text("What are Circles?", style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Inter',
                            color: Color.fromRGBO(100, 89, 89, 60),
                          ),),
        SizedBox(height: 16),
        Text("Circles are communities created by Wellth users", style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Inter',
                            color: Color.fromRGBO(100, 89, 89, 60),
                          ),),
        SizedBox(height: 16),
        Center(
          child: Image.asset('assets/img1-car.png', height: 201),
        ),
        SizedBox(height: 16),
        Text(
          "Users compete with one another against Wellth XP challenges made by the Circle’s creator, based on the circles topic",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20,
                            fontFamily: 'Inter',
                            color: Color.fromRGBO(100, 89, 89, 60),
                          ),
        ),
      ],
    ),

    // Page 1
    Column(
      key: ValueKey(1),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Habits:", style: TextStyle(
                            fontSize: 36, 
                            fontWeight: FontWeight.w500, 
                            fontFamily: 'Inter',
                            decoration: TextDecoration.underline
                          )),
        SizedBox(height: 16),
        Text("What are Habits?", style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Inter',
                            color: Color.fromRGBO(100, 89, 89, 60),
                          ),),
        SizedBox(height: 16),
        Text("Habits are healthy tasks done on a frequent basis.", style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Inter',
                            color: Color.fromRGBO(100, 89, 89, 60),
                          ),),
        SizedBox(height: 16),
        Center(
          child: Image.asset('assets/img2-car.png', height: 201),
        ),
        SizedBox(height: 16),
        Text(
          "Users set their own habits that work for their lifestyle.",
          textAlign: TextAlign.center,
          style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Inter',
                            color: Color.fromRGBO(100, 89, 89, 60),
                          ),
        ),
      ],
    ),

    //Page 2
    Column(
      key: ValueKey(2),
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Badges:", style: TextStyle(
                            fontSize: 36, 
                            fontWeight: FontWeight.w500, 
                            fontFamily: 'Inter',
                            decoration: TextDecoration.underline
                          )),
        SizedBox(height: 16),
        Text("What are Badges?", style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Inter',
                            color: Color.fromRGBO(100, 89, 89, 60),
                          ),),
        SizedBox(height: 16),
        Text("Badges are rewards users are given reflecting their achievements", style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'Inter',
                            color: Color.fromRGBO(100, 89, 89, 60),
                          ),),
        SizedBox(height: 16),
        Center(
          child: Image.asset('assets/img3-car.png', height: 201),
        ),
        SizedBox(height: 16),
        Text(
          "By completing Habits consistently or by fulfilling Circle challenges, Users can earn badges",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20,
                            fontFamily: 'Inter',
                            color: Color.fromRGBO(100, 89, 89, 60),
                          ),
        ),
      ],
    ),

    

  ];

  void _nextPage() {
    setState(() {
      _currentIndex = (_currentIndex + 1) % _carouselPages.length;
    });
  }

  void _prevPage() {
    setState(() {
      _currentIndex = (_currentIndex - 1) % _carouselPages.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              Text(
                'Welcome to Wellth',
                style: TextStyle(fontSize: 38, fontWeight: FontWeight.w500, fontFamily: 'Inter'),
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

              Text("Let's get your account setup!",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                )
              ),

              SizedBox(height: 24),

              // Gradient box with animated content inside
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
                  
                  child: AnimatedSwitcher(
                    duration: Duration(milliseconds: 400),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: Offset(.1, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    },
                    child: _carouselPages[_currentIndex],
                  ),
                ),
              ),

              Spacer(),

              //------------Continue & Go Back Buttons ------------//
              Row(
                children: [
                  Expanded(child: _buildButtonWhite("Go back", () {
                    if (_currentIndex == 0)
                    {
                      Navigator.of(context).push(
                        PageRouteBuilder(
                          settings: RouteSettings(name: '/userPermission'), // So it still integrates with named routes
                          
                          //Reverse Animation for prev page
                          pageBuilder: (context, animation, secondaryAnimation) => OnboardingScreen_permissions(), // Replace with your actual widget
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
                    _prevPage();
                  })),
                  SizedBox(width: 10),

                  Expanded(child: _buildButtonGradient("Continue", () {
                    if (_currentIndex == 2)
                    {
                      Navigator.of(context).pushNamed('/onboardingJoinCircle');
                    }
                    _nextPage();
                  })),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }



  //-------------------Geena's Button Design ---------------//

  //Gradient Button
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


  

  //Gradient Outline Button
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
*/

import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wellth_app/pages/onboarding_page_permissions.dart';
import 'package:wellth_app/components/gradient_button.dart';

class GradientPageSlider extends StatefulWidget {
  @override
  _GradientPageSliderState createState() => _GradientPageSliderState();
}

class _GradientPageSliderState extends State<GradientPageSlider> {
  final PageController _pageController = PageController();
  final int _pageCount = 3;

  //-----------Gradients--------------//
  final gradient = const LinearGradient(
    colors: [Colors.blue, Colors.purple, Colors.orange],
  );

  final gradientBlueOrange = const LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.pinkAccent, Colors.blue],
  );

  final List<Widget> _carouselPages = [
    // Page 0
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Circles:",
          style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
              decoration: TextDecoration.underline),
        ),
        SizedBox(height: 16),
        Text(
          "What are Circles?",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            color: Color.fromRGBO(100, 89, 89, 60),
          ),
        ),
        SizedBox(height: 16),
        Text(
          "Circles are communities created by Wellth users.",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            color: Color.fromRGBO(100, 89, 89, 60),
          ),
        ),
        SizedBox(height: 16),
        Center(
          child: Image.asset('assets/img1-car.png', height: 201),
        ),
        SizedBox(height: 16),
        Text(
          "Users compete with one another against Wellth XP challenges made by the Circle’s creator, based on the circles topic.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            color: Color.fromRGBO(100, 89, 89, 60),
          ),
        ),
      ],
    ),

    // Page 1
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Habits:",
          style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
              decoration: TextDecoration.underline),
        ),
        SizedBox(height: 16),
        Text(
          "What are Habits?",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            color: Color.fromRGBO(100, 89, 89, 60),
          ),
        ),
        SizedBox(height: 16),
        Text(
          "Habits are healthy tasks done on a frequent basis.",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            color: Color.fromRGBO(100, 89, 89, 60),
          ),
        ),
        SizedBox(height: 16),
        Center(
          child: Image.asset('assets/img2-car.png', height: 201),
        ),
        SizedBox(height: 16),
        Text(
          "Users set their own habits that work for their lifestyle.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            color: Color.fromRGBO(100, 89, 89, 60),
          ),
        ),
      ],
    ),

    // Page 2
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Badges:",
          style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w500,
              fontFamily: 'Inter',
              decoration: TextDecoration.underline),
        ),
        SizedBox(height: 16),
        Text(
          "What are Badges?",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            color: Color.fromRGBO(100, 89, 89, 60),
          ),
        ),
        SizedBox(height: 16),
        Text(
          "Badges are rewards users are given reflecting their achievements.",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            color: Color.fromRGBO(100, 89, 89, 60),
          ),
        ),
        SizedBox(height: 16),
        Center(
          child: Image.asset('assets/img3-car.png', height: 201),
        ),
        SizedBox(height: 16),
        Text(
          "By completing Habits consistently or by fulfilling Circle challenges, Users can earn badges.",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Inter',
            color: Color.fromRGBO(100, 89, 89, 60),
          ),
        ),
      ],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
          child: Column(
            children: [
              Text(
                'Welcome to Wellth',
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),

              Align(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 4),
                    Container(
                      height: 4,
                      width: 338,
                      decoration: BoxDecoration(
                        gradient: gradient,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5),

              Text(
                "Let's get your account setup!",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Inter',
                ),
              ),
              SizedBox(height: 24),

              // Gradient box with PageView
              Container(
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
                padding: EdgeInsets.all(2),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.all(10),
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: _carouselPages.length,
                    itemBuilder: (context, index) {
                      return _carouselPages[index];
                    },
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Smooth Page Indicator
              SmoothPageIndicator(
                controller: _pageController,
                count: _pageCount,
                effect: ExpandingDotsEffect(
                  activeDotColor: Colors.blueAccent, // active color
                  dotColor: Colors.grey.shade300, // inactive color
                  dotHeight: 10,
                  dotWidth: 10,
                  spacing: 6,
                  expansionFactor: 4,
                ),
              ),

              Spacer(),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: GradientButtonWhite(
                      text: "Go back",
                      onPressed: () {
                        if (_pageController.page == 0) {
                          PageRouteBuilder(
                            settings: RouteSettings(name: '/userPermission'), // So it still integrates with named routes
                            pageBuilder: (context, animation, secondaryAnimation) => OnboardingScreen_permissions(),
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
                          );
                        } else {
                          _pageController.previousPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        }
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: GradientButton(
                      text: "Continue",
                      onPressed: () {
                        if (_pageController.page == _pageCount - 1) {
                          Navigator.of(context)
                              .pushNamed('/onboardingJoinCircle');
                        } else {
                          _pageController.nextPage(
                              duration: Duration(milliseconds: 300),
                              curve: Curves.easeInOut);
                        }
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

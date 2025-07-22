
import 'package:firebase_core/firebase_core.dart';                  // Added from codelab
import 'package:flutter/material.dart';
import 'package:wellth_app/auth/login_or_register.dart';
import 'package:wellth_app/home.dart';
import 'package:wellth_app/pages/custom_login_page.dart';
import 'package:wellth_app/pages/register_page.dart';

import 'package:cloud_firestore/cloud_firestore.dart'; // Used for database functionality



import 'app.dart';
import 'firebase_options.dart'; 
import 'pages/custom_login_page.dart';
import 'pages/register_page.dart';
import 'package:wellth_app/auth/auth.dart';
import 'pages/home_page.dart';
import 'pages/onboarding_page_bio.dart';
import 'pages/onboarding_page_permissions.dart';
import 'pages/onboarding_page_carousel_circles.dart';
import 'pages/onboarding_page_carousel_habits.dart';
import 'pages/information_carousel.dart';

// Added from codelab

// Sets Google API key for Google sign-in
const clientId = '600688007911-m0c0a2tmvf3bk21itqh4vkcod40566jv.apps.googleusercontent.com';

// Initializes a database on Firebase backend
var db = FirebaseFirestore.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp(clientId: clientId));
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key, required String clientId});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //home: UserInformationPage(),
      home: GradientPageSlider(),
      routes: {
        '/register': (context) => RegisterPage(), // Register page route
        '/login': (context) => CustomLoginPage(), // Custom login page route
        '/userInformation': (context) => OnboardingScreen_bio(),
        '/userPermission': (context) => OnboardingScreen_permissions(),
        '/userProfile': (context) => HomePage(),

        '/informationCarousel': (context) => GradientPageSlider(),
        '/carouselCircles': (context) => OnboardingScreen_carousel_circles(),
        '/carouselHabits': (context) => OnboardingScreen_carousel_habits(),
      
      },
      //home: AuthPage(),

      //temp to setup register page - need to implement routes

      //home: CustomLoginPage(clientId: clientId,),
      //home: HomeScreen(),
    );
    // Define routes

  }
}



// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (context) => MyAppState(),
//       child: MaterialApp(
//         title: 'Namer App',
//         theme: ThemeData(
//           colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
//         ),
//         home: MyHomePage(),
//       ),
//     );
//   }
// }

// class MyAppState extends ChangeNotifier {
//   var current = WordPair.random();
// }

// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     var appState = context.watch<MyAppState>();

//     return Scaffold(
//       body: Column(
//         children: [Text('A random DOPE idea:'), 
//         Text(appState.current.asLowerCase),
        
//         ElevatedButton(
//           onPressed: () {
//             print('button pressed!');
//           },
//           child: Text('Next'),
//         ),
        
//         ],
//       ),
//     );
//   }
// }
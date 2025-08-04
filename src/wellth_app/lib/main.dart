import 'package:firebase_core/firebase_core.dart'; // Added from codelab
import 'package:flutter/material.dart';
import 'package:wellth_app/home.dart';
import 'package:wellth_app/pages/custom_login_page.dart';
import 'package:wellth_app/pages/register_page.dart';
import 'package:wellth_app/pages/profile_page.dart';

import 'package:cloud_firestore/cloud_firestore.dart'; // Used for database functionality
import 'package:firebase_auth/firebase_auth.dart';

import 'app.dart';
import 'firebase_options.dart';
import 'pages/custom_login_page.dart';
import 'pages/register_page.dart';
import 'package:wellth_app/auth/auth.dart';
import 'pages/onboarding_page_bio.dart';
import 'pages/onboarding_page_permissions.dart';
import 'pages/landing_page.dart';
import 'pages/onboarding_wizard_complete.dart';
import 'pages/onboarding_wizard_join_circle.dart';
import 'pages/onboarding_wizard_privacy.dart';
import 'pages/information_carousel.dart';
import 'pages/circles_announcement_detail_page.dart';
import 'pages/circles_announcement_page.dart';
import 'pages/circles_details_page.dart';
import 'pages/circles_feeds_page.dart';
import 'pages/circles_members_page.dart';
import 'pages/circles_new_announcement_page.dart';
import 'pages/circles_page.dart';
import 'pages/route_tracker.dart';

String? globalProfileImagePath;

// Added from codelab

// Sets Google API key for Google sign-in
const clientId =
    '600688007911-m0c0a2tmvf3bk21itqh4vkcod40566jv.apps.googleusercontent.com';

// Initializes a database on Firebase backend
var db = FirebaseFirestore.instance;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAuth.instance.signOut();

  runApp(const MyApp(clientId: clientId));
}

// class MyApp extends StatelessWidget {
//   const MyApp ({super.key, required String clientId});

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,

//       home: CustomLoginPage(),
//       //home: ProfileScreen(),
//       routes: {
//         '/register': (context) => RegisterPage(), // Register page route
//         '/login': (context) => CustomLoginPage(), // Custom login page route
//         '/userInformation': (context) => OnboardingScreen_bio(),//first page onboarding wizard
//         '/userPermission': (context) => OnboardingScreen_permissions(),//second page onboarding wizard
//         '/informationCarousel': (context) => GradientPageSlider(),//onboarding carousel (thrid page)
//         '/onboardingPermissions': (context) => OnboardingScreen_permissions(), // Initial onboarding permissions screen
//         '/onboardingJoinCircle': (context) => OnboardingJoinCircleScreen(),//Fourth page onboarding wizard
//         '/onboardingPrivacy': (context) => OnboardingPrivacyScreen(),//fith page onboarding wizard
//         '/onboardingComplete': (context) => OnboardingCompleteScreen(),//sixth/last page onboarding wizard
//         '/userProfile': (context) => ProfileScreen(),
//         '/landingPage': (context) => LandingPageScreen(),
//       },
//       //home: AuthPage(),

//       //temp to setup register page - need to implement routes

//       //home: CustomLoginPage(clientId: clientId,),
//       //home: HomeScreen(),
//     );
//     // Define routes

//   }
// }

class MyApp extends StatelessWidget {
  const MyApp({super.key, required String clientId});

  @override
  Widget build(BuildContext context) {
    final routeTracker = RouteTracker();
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      //home: CustomLoginPage(),
      //home: ProfileScreen(), // Initial screen for onboarding
      //home: OnboardingScreen_bio(),
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(child: CircularProgressIndicator()),
            );
          }
          if (snapshot.hasData) {
            return const LandingPageScreen();
          }
          return const CustomLoginPage();
        },
      ),

      onGenerateRoute: (RouteSettings settings) {
        final args = settings.arguments as Map<String, dynamic>?;

        switch (settings.name) {
          case '/register':
            return MaterialPageRoute(builder: (_) => RegisterPage());

          case '/login':
            return MaterialPageRoute(builder: (_) => CustomLoginPage());

          case '/userInformation':
            return MaterialPageRoute(builder: (_) => OnboardingScreen_bio());

          case '/userPermission':
            return MaterialPageRoute(
              builder: (_) => OnboardingScreen_permissions(),
            );

          case '/informationCarousel':
            return MaterialPageRoute(builder: (_) => GradientPageSlider());

          case '/onboardingJoinCircle':
            return MaterialPageRoute(
              builder: (_) => OnboardingJoinCircleScreen(),
            );

          case '/onboardingPrivacy':
            return MaterialPageRoute(builder: (_) => OnboardingPrivacyScreen());

          case '/onboardingComplete':
            return MaterialPageRoute(
              builder: (_) => OnboardingCompleteScreen(),
            );

          case '/landingPage':
            return MaterialPageRoute(builder: (_) => LandingPageScreen());

          case '/userProfile':
            return MaterialPageRoute(builder: (_) => ProfileScreen(profilePicturePath: globalProfileImagePath));

          case '/circlesAnnouncementDetail':
            if (args == null) {
              throw Exception('announcement data is required');
            }
            return MaterialPageRoute(
              builder: (_) => CirclesAnnouncementDetailPage(announcement: args),
            );

          case '/circlesAnnouncements':
            if (args == null) {
              throw Exception('circle data is required');
            }
            return MaterialPageRoute(
              builder: (_) => CirclesAnnouncementsPage(circle: args),
            );

          case '/CircleDetail':
            if (args == null) {
              throw Exception('circle data is required');
            }
            return MaterialPageRoute(
              builder: (_) => CircleDetailScreen(circle: args),
            );

          case '/CircleFeed':
            if (args == null) {
              throw Exception('circle data is required');
            }
            return MaterialPageRoute(
              builder: (_) => CircleFeedPage(circle: args),
            );

          case '/CircleMembers':
            if (args == null) {
              throw Exception('circle data is required');
            }
            return MaterialPageRoute(
              builder: (_) => CircleMembersPage(circle: args),
            );

          case '/CirclesNewAnnouncement':
            if (args == null) {
              throw Exception('circle data is required');
            }
            return MaterialPageRoute(
              builder: (_) => CirclesNewAnnouncementPage(circle: args),
            );

          case '/Circles':
            return MaterialPageRoute(builder: (_) => CirclesScreen());

          // default:
          //   return MaterialPageRoute(builder: (_) => CustomLoginPage());
        }
      },
    );
  }
}

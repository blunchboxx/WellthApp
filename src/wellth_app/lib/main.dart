
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
import 'pages/user_information.dart';

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
      routes: {
        '/register': (context) => RegisterPage(), // Register page route
        '/login': (context) => CustomLoginPage(), // Custom login page route
        '/userInformation': (context) => UserInformationPage(),
        '/userProfile': (context) => HomePage()
      
      },
      home: AuthPage(),

      //temp to setup register page - need to implement routes

      //home: CustomLoginPage(clientId: clientId,),
      //home: HomeScreen(),
    );
    // Define routes

  }
}
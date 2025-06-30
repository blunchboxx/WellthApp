import 'package:flutter/material.dart';

import 'auth_gate.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wellth_app/pages/register_page.dart'; // Import your register page
import 'package:wellth_app/pages/custom_login_page.dart';




class MyLabelOverrides extends DefaultLocalizations {
  const MyLabelOverrides();

 // @override
 // String get emailInputLabel => 'Your e-mail address';   
  


 @override
  String get signInText => 'Sign In';              // label over the email TextField :contentReference[oaicite:0]{index=0}

 // @override
  //String get passwordInputLabel => 'Super-secret password';          // label over the password TextField

 // @override
  //String get signInActionText => 'Let me in!';                       // text on the “Sign in” button

 // @override
  //String get forgotPasswordButtonLabel => 'Can’t remember? Reset';   // text of the “Forgot password” link

}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.clientId});

  final String clientId;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white, surface: Colors.white),
        textTheme: GoogleFonts.interTextTheme(Theme.of(context).textTheme),
      ),supportedLocales: const [ Locale('en') ],
      localizationsDelegates: [
        // 1) Our overrides go first
        FirebaseUILocalizations.withDefaultOverrides(const MyLabelOverrides()),
        // 2) Flutter’s built-in localization
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        // 3) Finally, the base FirebaseUI delegate
        FirebaseUILocalizations.delegate,
      ],
      home: AuthGate(clientId: clientId),
    );
  }
}
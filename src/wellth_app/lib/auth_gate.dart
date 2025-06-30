import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wellth_app/pages/register_page.dart';
import 'pages/custom_login_page.dart';
import 'home.dart';
import 'auth/login_or_register.dart';

/// Wraps your app and decides whether to show the login page or HomeScreen.
class AuthGate extends StatelessWidget {
  const AuthGate({super.key, required this.clientId});

  /// Your Google OAuth client ID from the Firebase console
  final String clientId;
  //final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // If the user is NOT signed in, show the custom login page
        if (!snapshot.hasData) {

          
          //return CustomLoginPage(onTap: togglePages,);

        }
        // Otherwise, show the home screen
        return const HomeScreen();
        
      },
    );
  }
}

// ```

// The headerBuilder argument requires a function of the type HeaderBuilder, which
// is defined in the FlutterFire UI package.

// ```dart

typedef HeaderBuilder = Widget Function(
 BuildContext context,
 BoxConstraints constraints,
 double shrinkOffset,
);

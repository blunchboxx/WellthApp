import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:wellth_app/auth/login_or_register.dart';
import 'package:wellth_app/pages/profile_page.dart';
import 'package:wellth_app/pages/custom_login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthPage extends StatelessWidget{
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(), 
        builder: (context, snapshot){
          //user is logged in
          if(snapshot.hasData){
            return ProfileScreen();
          }
          //user not logged in
          else{
            return  const CustomLoginPage();
          }
        }
        )
    );
  }
}

// lib/services/auth_service.dart

class AuthService {
  final _auth = FirebaseAuth.instance;

  

  Future<UserCredential> signInWithEmail(String email, String password) {
    return _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  Future<UserCredential> registerWithEmail(String email, String password) {
    return _auth.createUserWithEmailAndPassword(email: email, password: password);
  }

  // ... any other auth methods
}
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';                  // Added from codelab
import 'package:flutter/material.dart';

// Create a new circle and make user admin
Future<void> createCircle(String circleName, String description) async {
  final user = FirebaseAuth.instance.currentUser;
  final circlesRef = FirebaseFirestore.instance.collection('circles');

  final newCircle = await circlesRef.add({
    'name': circleName,
    'description': description,
    'createdBy': user!.uid,
    'members': [user.uid],
    'roles': { user.uid: 'admin' },
    'createdAt': FieldValue.serverTimestamp(),
  });

  // Add circle to user's profile
  await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
    'circles': FieldValue.arrayUnion([newCircle.id])
  });
}

// ALlow user to join an existing circle
// note: This function assumes the circle already exists and the user is authenticated.
Future<void> joinCircle(String circleId) async {
  final user = FirebaseAuth.instance.currentUser;
  final circleRef = FirebaseFirestore.instance.collection('circles').doc(circleId);

  await circleRef.update({
    'members': FieldValue.arrayUnion([user!.uid]),
    'roles.${user.uid}': 'member',
  });

  await FirebaseFirestore.instance.collection('users').doc(user.uid).update({
    'circles': FieldValue.arrayUnion([circleId])
  });
}

// Check user role in a circle
Future<String?> getUserRole(String circleId) async {
  final user = FirebaseAuth.instance.currentUser;
  final doc = await FirebaseFirestore.instance.collection('circles').doc(circleId).get();

  return doc.data()?['roles']?[user!.uid];
}



// Future<void> createUserProfile() async {
//   final user = FirebaseAuth.instance.currentUser;
//   final userRef = FirebaseFirestore.instance.collection('users').doc(user!.uid);

//   final userDoc = await userRef.get();

//   if (!userDoc.exists) {
//     await userRef.set({
//       'email': user.email,
//       'username': "", // To be collected later in user_information
//       'firstName': "",
//       'lastName': "",
//       'age': -1,
//       'bio': "",
//       'createdAt': FieldValue.serverTimestamp(),
//       'hasCompletedOnboarding': false, // Sets flag for determining if user will be sent to onboarding wizard
//       // 'preferences': {
//       //   'notifications': true,
//       //   'theme': 'light'
//       // },
//     });
//   }
// }
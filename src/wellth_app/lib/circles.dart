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

// Allow user to leave a circle
Future<void> leaveCircle(String circleId) async {
  print('fill in later with logic to leave circle');

}

// Check user role in a circle
Future<String?> getUserRole(String circleId) async {
  final user = FirebaseAuth.instance.currentUser;
  final doc = await FirebaseFirestore.instance.collection('circles').doc(circleId).get();

  return doc.data()?['roles']?[user!.uid];
}



/// Fetches the “top 10” circles (ordered by createdAt descending)
/// and returns a List of maps containing each doc’s id & name.
Future<List<Map<String, String>>> fetchTop10Circles() async {
  // 1) Run your query once (descending newest-first—flip that flag if you want oldest-first)
  final snap = await FirebaseFirestore.instance
    .collection('circles')
    .orderBy('createdAt', descending: false)
    .limit(10)
    .get();

  // 2) Log raw data so you can inspect exactly what doc.data() looks like
  for (final doc in snap.docs) {
    print('🔍 doc ${doc.id} → raw data: ${doc.data()}');
    final raw = doc.data() as Map<String, dynamic>;
    print('   name field runtimeType: ${raw['name'].runtimeType}');
  }

  // 3) Map each doc to a simple {id, name} map
  return snap.docs.map((doc) {
    String name;

    // Try the plugin’s unwrapped getter first:
    final dynamic maybeName = doc.get('name');
    if (maybeName is String) {
      name = maybeName;
    } else if (maybeName is Map<String, dynamic> &&
               maybeName.containsKey('stringValue')) {
      // Fallback: manual unwrap of { stringValue: "..." }
      name = maybeName['stringValue'] as String;
    } else {
      // Last resort: stringify whatever it is
      name = maybeName?.toString() ?? '';
    }

    return {
      'id': doc.id,
      'name': name,
    };
  }).toList();
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
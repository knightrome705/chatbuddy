import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class LoginProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> login(String email, String password) async {
    try {
      // Sign in with email and password
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email.trim(),
        password: password.trim(),
      );

      // Get user ID
      final userId = userCredential.user!.uid;

      // Update or create Firestore document with user status
      final userDocRef = _firestore.collection('users').doc(userId);

      // Check if the user document exists
      final userDoc = await userDocRef.get();

      if (userDoc.exists) {
        // Update Firestore with user status
        await userDocRef.update({
          'status': 'online',
          'lastOnline': FieldValue.serverTimestamp(),
        });
      } else {
        // Create Firestore document if it does not exist
        await userDocRef.set({
          'email': email.trim(),
          'status': 'online',
          'lastOnline': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }
}

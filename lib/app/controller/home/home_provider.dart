// home_provider.dart
import 'package:chatbuddy/app/common/toast_message.dart';
import 'package:chatbuddy/app/routes/route_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> updateUserStatus(String userId, String status) async {
    try {
      await _firestore.collection('users').doc(userId).update({
        'status': status,
      });
    } catch (e) {
      print('Error updating status: $e');
    }
  }

  String formatLastOnlineTime(Timestamp? lastOnline) {
    if (lastOnline == null) return 'Unknown';

    try {
      final dateTime = lastOnline.toDate();
      final timeFormat = DateFormat('HH:mm');
      return timeFormat.format(dateTime);
    } catch (e) {
      print('Error formatting lastOnline time: $e');
      return 'Unknown';
    }
  }

  Stream<QuerySnapshot> getUsersStream() {
    return _firestore.collection('users').snapshots();
  }

  Future<void> logout(BuildContext context) async {
    final user = _auth.currentUser;

    if (user != null) {
      await updateUserStatus(user.uid, 'offline'); // Update status to offline

      try {
        await _auth.signOut();
        Navigator.pushReplacementNamed(context, loginScreenRoute);
      } catch (e) {
        showToastMessage(message: 'Error logging out: ${e.toString()}');
      }
    }
  }
}

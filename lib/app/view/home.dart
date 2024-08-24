import 'package:chatbuddy/app/common/toast_message.dart';
import 'package:chatbuddy/app/routes/route_constants.dart';
import 'package:chatbuddy/app/widget/user_listtile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chats'),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat),
            onPressed: () {
              showToastMessage(message: "currently unavailable");
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              showToastMessage(message: "currently unavailable");
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('No users available'));
          }

          final users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              final name = user['name'] as String? ?? 'Unknown';
              final lastMessage = user['status'] as String? ?? 'No messages yet';

              // Extract and format the lastOnline timestamp
              final lastOnline = user['lastOnline'] as Timestamp?;
              final lastOnlineTime = _formatLastOnlineTime(lastOnline);

              final profilePicture = user['profilePicture'] as String? ?? 'assets/images/logo.jpg';

              return UserListTile(
                name: name,
                lastMessage: lastMessage,
                time: lastOnlineTime,
                profilePicture: profilePicture,
                receiverId: user.id, // Pass these parameters
                receiverName: name,
                receiverImage: profilePicture,
              );
            },
          );
        },
      ),
    );
  }

  String _formatLastOnlineTime(Timestamp? lastOnline) {
    if (lastOnline == null) return 'Unknown';

    try {
      // Convert Firestore Timestamp to DateTime
      final dateTime = lastOnline.toDate();

      // Format the time
      final timeFormat = DateFormat('HH:mm');
      return timeFormat.format(dateTime);
    } catch (e) {
      print('Error formatting lastOnline time: $e');
      return 'Unknown';
    }
  }

  Future<void> _logout(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      Navigator.pushReplacementNamed(context, loginScreenRoute);
    } catch (e) {
      showToastMessage(message: 'Error logging out: ${e.toString()}');
    }
  }
}

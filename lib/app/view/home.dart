import 'package:chatbuddy/app/widget/user_listtile.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Import Firebase Firestore

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
              // Add new chat action
            },
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              // Add more options action
            },
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
              final name = user['email'];
              // final lastMessage = user['lastMessage'] ?? 'No messages yet';
              // final time = user['lastMessageTime'] ?? 'Unknown';
              final profilePicture = user['profilePicture'] ?? 'assets/images/logo.jpg';

              return UserListTile(
                name: name,
                lastMessage: "null",
                time: "time",
                profilePicture: profilePicture,
              );
            },
          );
        },
      ),
    );
  }
}

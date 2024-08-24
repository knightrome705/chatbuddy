import 'package:chatbuddy/app/widget/user_listtile.dart';
import 'package:flutter/material.dart';

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
      body: ListView(
        children: [
          UserListTile(
            name: 'John Doe',
            lastMessage: 'Hey, how are you?',
            time: '12:45 PM',
            profilePicture: 'assets/images/user1.jpg',
          ),
          UserListTile(
            name: 'Jane Smith',
            lastMessage: 'Can we meet tomorrow?',
            time: '11:30 AM',
            profilePicture: 'assets/images/user2.jpg',
          ),
          UserListTile(
            name: 'Michael Brown',
            lastMessage: 'Don\'t forget the meeting!',
            time: 'Yesterday',
            profilePicture: 'assets/images/user3.jpg',
          ),
          // Add more UserListTile widgets here
        ],
      ),
    );
  }
}
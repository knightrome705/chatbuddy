import 'package:chatbuddy/app/widget/chat_bubble.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
        actions: [
          IconButton(
            icon: const Icon(Icons.video_call),
            onPressed: () {
              // Add video call action
            },
          ),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              // Add voice call action
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              reverse: true, // To show latest messages at the bottom
              children: [
                // Example chat bubbles
                ChatBubble(isSent: true, message: 'Hey there!'),
                ChatBubble(isSent: false, message: 'Hello! How are you?'),
                ChatBubble(isSent: true, message: 'I am good, thanks.'),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Type a message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.grey[200],
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    // Add send message action
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
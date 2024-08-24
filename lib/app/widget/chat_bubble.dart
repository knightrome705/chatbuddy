import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final bool isSent;
  final String message;

  const ChatBubble({
    Key? key,
    required this.isSent,
    required this.message,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        decoration: BoxDecoration(
          color: isSent ? Colors.blue[200] : Colors.grey[300],
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          message,
          style: TextStyle(color: isSent ? Colors.black : Colors.black87),
        ),
      ),
    );
  }
}
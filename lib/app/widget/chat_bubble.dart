import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final bool isSent;
  final String message;
  final DateTime time;
  final String userName;

  const ChatBubble({
    Key? key,
    required this.isSent,
    required this.message,
    required this.time,
    required this.userName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        mainAxisAlignment: isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isSent) 
            CircleAvatar(
              backgroundImage: const AssetImage('assets/icons/user.png'), 
              backgroundColor: Colors.grey[300],
            ),
          const SizedBox(width: 8),
          Flexible(
            child: Column(
              crossAxisAlignment: isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    color: isSent ? Colors.blue : Colors.grey[300],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    message,
                    style: TextStyle(
                      color: isSent ? Colors.white : Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '${time.hour}:${time.minute}',
                  style: TextStyle(
                    color: isSent ? Colors.white70 : Colors.black54,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          if (isSent) 
            const SizedBox(width: 8),
          if (isSent)
            CircleAvatar(
              backgroundImage: const AssetImage('assets/icons/user.png'), 
              backgroundColor: Colors.grey[300],
            ),
        ],
      ),
    );
  }
}

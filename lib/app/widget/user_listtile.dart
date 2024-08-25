import 'package:chatbuddy/app/routes/route_constants.dart';
import 'package:flutter/material.dart';

class UserListTile extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String time;
  final String profilePicture;
  final String receiverId; // Add this line
  final String receiverName; // Add this line
  final String receiverImage; // Add this line

  const UserListTile({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.profilePicture,
    required this.receiverId, // Add this line
    required this.receiverName, // Add this line
    required this.receiverImage, // Add this line
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.pushNamed(
          context,
          chatScreenRoute,
          arguments: {
            'receiverId': receiverId,
            'receiverName': receiverName,
            'receiverImage': receiverImage,
            'receiverStatus':lastMessage
          },
        );
      },
      leading: CircleAvatar(
        backgroundImage: NetworkImage(profilePicture),
        backgroundColor: Colors.grey[200], // Default background color if image is not loaded
      ),
      title: Text(name),
      subtitle: Text(lastMessage),
      trailing: Text(time),
    );
  }
}

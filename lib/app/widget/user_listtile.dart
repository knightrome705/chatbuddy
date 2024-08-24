import 'package:flutter/material.dart';

class UserListTile extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String time;
  final String profilePicture;

  const UserListTile({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.profilePicture,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
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

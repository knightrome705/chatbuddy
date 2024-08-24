import 'package:chatbuddy/app/routes/screen_export.dart';
import 'package:flutter/material.dart';

class UserListTile extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String time;
  final String profilePicture;

  const UserListTile({
    Key? key,
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.profilePicture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(profilePicture),
      ),
      title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(lastMessage),
      trailing: Text(time, style: const TextStyle(color: Colors.grey)),
      onTap: () {
        // Navigate to the chat screen or perform another action
        Navigator.pushNamed(context, chatScreenRoute);
      },
    );
  }
}

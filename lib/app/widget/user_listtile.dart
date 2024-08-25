import 'package:chatbuddy/app/routes/route_constants.dart';
import 'package:flutter/material.dart';

class UserListTile extends StatelessWidget {
  final String name;
  final String lastMessage;
  final String time;
  final String profilePicture;
  final String receiverId; 
  final String receiverName; 
  final String receiverImage; 

  const UserListTile({
    required this.name,
    required this.lastMessage,
    required this.time,
    required this.profilePicture,
    required this.receiverId, 
    required this.receiverName, 
    required this.receiverImage, 
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
        backgroundColor: Colors.grey[200], 
      ),
      title: Text(name),
      subtitle: Text(lastMessage),
      trailing: Text(time),
    );
  }
}

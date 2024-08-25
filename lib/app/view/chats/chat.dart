// chat_screen.dart
import 'package:chatbuddy/app/common/toast_message.dart';
import 'package:chatbuddy/app/controller/chats/chat_provider.dart';
import 'package:chatbuddy/app/view/chats/widget/message_input.dart';
import 'package:chatbuddy/app/widget/chat_bubble.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  final String receiverId;
  final String receiverName;
  final String receiverImage;
  final String receiverStatus;

  const ChatScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
    required this.receiverImage,
    required this.receiverStatus,
  });

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    final messageController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(receiverImage),
                ),
                const SizedBox(width: 10),
                Text(receiverName),
                Text("(${receiverStatus})", style: TextStyle(fontSize: 10)),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.video_call),
            onPressed: () {
              showToastMessage(message: "currently unavailable");
            },
          ),
          IconButton(
            icon: const Icon(Icons.call),
            onPressed: () {
              showToastMessage(message: "currently unavailable");
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                StreamBuilder<QuerySnapshot>(
                  stream: chatProvider.getMessagesStream(chatProvider.getChatId(
                      FirebaseAuth.instance.currentUser?.uid ?? '', receiverId)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                      return const Center(child: Text('No messages yet.'));
                    }

                    final chatDocs = snapshot.data!.docs;
                    return ListView.builder(
                      reverse: true, // To show the latest messages at the bottom
                      itemCount: chatDocs.length,
                      itemBuilder: (context, index) {
                        final chat = chatDocs[index].data() as Map<String, dynamic>;
                        final isSent = chat['senderId'] == FirebaseAuth.instance.currentUser?.uid;
                        return ChatBubble(
                          isSent: isSent,
                          message: chat['text'],
                          time: (chat['createdAt'] as Timestamp).toDate(),
                          userName: chat['senderName'],
                        );
                      },
                    );
                  },
                ),
                if (chatProvider.isEmojiPickerVisible)
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: SizedBox(
                      height: 250,
                      child: EmojiPicker(
                        onEmojiSelected: (category, emoji) {
                          chatProvider.addEmojiToMessage(messageController, emoji);
                        },
                      ),
                    ),
                  ),
              ],
            ),
          ),
          MessageInput(
            messageController: messageController,
            onSendMessage: () async {
              await chatProvider.sendMessage(receiverId, messageController.text.trim());
              messageController.clear();
            },
            isEmojiPickerVisible: chatProvider.isEmojiPickerVisible,
            onToggleEmojiPicker: chatProvider.toggleEmojiPicker,
          ),
        ],
      ),
    );
  }
}

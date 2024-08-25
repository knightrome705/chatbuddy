import 'package:chatbuddy/app/common/toast_message.dart';
import 'package:chatbuddy/app/view/chats/widget/message_input.dart';
import 'package:chatbuddy/app/widget/chat_bubble.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatefulWidget {
  final String receiverId;
  final String receiverName;
  final String receiverImage;
  final String recieverStatus;

  const ChatScreen({
    super.key,
    required this.receiverId,
    required this.receiverName,
    required this.receiverImage, 
    required this.recieverStatus,
  });

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _isEmojiPickerVisible = false;

  Future<void> _sendMessage() async {
    final messageText = _messageController.text.trim();

    if (messageText.isNotEmpty) {
      final user = _auth.currentUser;
      if (user != null) {
        final chatId = _getChatId(user.uid, widget.receiverId);

        await _firestore
            .collection('chats')
            .doc(chatId)
            .collection('messages')
            .add({
          'text': messageText,
          'createdAt': Timestamp.now(),
          'senderId': user.uid,
          'senderName': user.displayName ?? 'Anonymous',
          'receiverId': widget.receiverId,
        });

        showToastMessage(message: "Message sent");
        _messageController.clear();
        setState(() {
          _isEmojiPickerVisible =
              false; 
        });
      }
    }
  }


  String _getChatId(String userId, String receiverId) {
    return userId.hashCode <= receiverId.hashCode
        ? '$userId-$receiverId'
        : '$receiverId-$userId';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          
          Positioned.fill(
            child: Image.asset(
              'assets/images/background.jpg', 
              fit: BoxFit.cover,
            ),
          ),
         
          Column(
            children: [
              AppBar(
                title: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(widget.receiverImage),
                        ),
                        const SizedBox(width: 10),
                        Text(widget.receiverName),
                        Text(
                          "(${widget.recieverStatus})",
                          style: const TextStyle(fontSize: 10),
                        ),
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
              Expanded(
                child: Stack(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                      stream: _firestore
                          .collection('chats')
                          .doc(_getChatId(
                              _auth.currentUser?.uid ?? '', widget.receiverId))
                          .collection('messages')
                          .orderBy('createdAt', descending: true)
                          .snapshots(),
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
                          reverse:
                              true,
                          itemCount: chatDocs.length,
                          itemBuilder: (context, index) {
                            final chat =
                                chatDocs[index].data() as Map<String, dynamic>;
                            final isSent =
                                chat['senderId'] == _auth.currentUser?.uid;
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
                    if (_isEmojiPickerVisible)
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: SizedBox(
                          height: 250,
                          child: EmojiPicker(
                            onEmojiSelected: (category, emoji) {
                              setState(() {
                                _messageController.text += emoji.emoji;
                              });
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              MessageInput(
                messageController: _messageController,
                onSendMessage: _sendMessage,
                isEmojiPickerVisible: _isEmojiPickerVisible,
                onToggleEmojiPicker: () {
                  setState(() {
                    _isEmojiPickerVisible = !_isEmojiPickerVisible;
                  });
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

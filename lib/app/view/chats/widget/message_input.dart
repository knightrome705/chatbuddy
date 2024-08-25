
import 'package:flutter/material.dart';

class MessageInput extends StatefulWidget {
  final TextEditingController messageController;
  final VoidCallback onSendMessage;
  final bool isEmojiPickerVisible;
  final VoidCallback onToggleEmojiPicker;

  const MessageInput({
    Key? key,
    required this.messageController,
    required this.onSendMessage,
    required this.isEmojiPickerVisible,
    required this.onToggleEmojiPicker,
  }) : super(key: key);

  @override
  _MessageInputState createState() => _MessageInputState();
}

class _MessageInputState extends State<MessageInput> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.emoji_emotions),
            onPressed: widget.onToggleEmojiPicker,
          ),
          Expanded(
            child: TextField(
              controller: widget.messageController,
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
              onSubmitted: (_) => widget.onSendMessage(),
            ),
          ),
          FloatingActionButton(
            backgroundColor: Colors.blue,
            onPressed:widget.onSendMessage,child:const Icon(Icons.send,color: Colors.white,) , )
          // IconButton(
          //   icon: const Icon(Icons.send,color: Colors.blue,),
          //   onPressed: widget.onSendMessage,
          // ),
        ],
      ),
    );
  }
}

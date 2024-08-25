

//dead codes // the emojis is not accepted by the controller

// import 'package:flutter/material.dart';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class ChatProvider with ChangeNotifier {
//   final FirebaseAuth _auth = FirebaseAuth.instance;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   bool _isEmojiPickerVisible = false;
//   bool get isEmojiPickerVisible => _isEmojiPickerVisible;

//   void toggleEmojiPicker() {
//     _isEmojiPickerVisible = !_isEmojiPickerVisible;
//     notifyListeners();
//   }

//   void addEmojiToMessage(TextEditingController controller, Emoji emoji) {
//     controller.text += emoji.emoji;
//     notifyListeners();
//   }

//   Future<void> sendMessage(String receiverId, String messageText) async {
//     final user = _auth.currentUser;
//     if (user != null && messageText.isNotEmpty) {
//       final chatId = _getChatId(user.uid, receiverId);

//       await _firestore
//           .collection('chats')
//           .doc(chatId)
//           .collection('messages')
//           .add({
//         'text': messageText,
//         'createdAt': Timestamp.now(),
//         'senderId': user.uid,
//         'senderName': user.displayName ?? 'Anonymous',
//         'receiverId': receiverId,
//       });
//     }
//   }

//   String _getChatId(String userId, String receiverId) {
//     return userId.hashCode <= receiverId.hashCode
//         ? '$userId-$receiverId'
//         : '$receiverId-$userId';
//   }

//   Stream<QuerySnapshot> getMessagesStream(String chatId) {
//     return _firestore
//         .collection('chats')
//         .doc(chatId)
//         .collection('messages')
//         .orderBy('createdAt', descending: true)
//         .snapshots();
//   }
// }

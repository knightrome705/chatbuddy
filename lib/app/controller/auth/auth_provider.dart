import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  File? _imageFile;
  final ImagePicker _picker = ImagePicker();

  File? get imageFile => _imageFile;

  Future<void> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _imageFile = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<String> uploadImage() async {
    if (_imageFile == null) {
      return '';
    }
    try {
      final fileName = DateTime.now().toString();
      final storageRef = FirebaseStorage.instance.ref().child('profile_pictures/$fileName');
      final uploadTask = storageRef.putFile(_imageFile!);
      final snapshot = await uploadTask.whenComplete(() => {});
      final imageUrl = await snapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      return '';
    }
  }

  Future<void> signUp(String email, String password, String name) async {
    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final imageUrl = await uploadImage();

      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'email': email,
        'status': 'online',
        'lastOnline': FieldValue.serverTimestamp(),
        'profilePicture': imageUrl,
      });
    } catch (e) {
      throw Exception('Error: ${e.toString()}');
    }
  }
}

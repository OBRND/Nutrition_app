import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  String? subscription;
  final String uid;

  UserProvider({required this.uid});

  Future<void> loadUserData() async {
    try {
      final userRef = FirebaseFirestore.instance.collection('Users');
      final userInfo = await userRef.doc(uid).get();

      if (userInfo.exists) {
        // Access the desired fields from the user document
        subscription = userInfo.data()?['subscription'] ?? '';
        print("+++++++++++++++++++++++++++++++++++++++++++++++++");
        print(subscription);
      }

      notifyListeners();
    } catch (e) {
      // Handle any potential errors
      print('Error fetching user data: $e');
    }
  }
}

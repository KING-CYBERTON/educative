import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:educative/Datamodels/UserModel.dart';
import 'package:educative/controllers/AuthController.dart';

class FireRepo extends GetxController {
  static FireRepo instance = Get.find();

  final _db = FirebaseFirestore.instance;
  final uid = FirebaseAuth.instance.currentUser?.uid;
    final email = FirebaseAuth.instance.currentUser?.email;

  createUser(UserData user) async {
    await _db
        .collection("Users")
        .add(user.toJson())
        .whenComplete(
          () => Get.snackbar('success', 'Info has been updated',
              snackPosition: SnackPosition.TOP,
              backgroundColor: Colors.greenAccent.withOpacity(0.2),
              colorText: Colors.black87),
        )
        .catchError((e) {
      Get.snackbar('Error', 'Something went wrong',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent.withOpacity(0.2),
          colorText: Colors.black);
    });
  }

  editUser(UserData user) async {
  // Get the current user's email
  final currentUserEmail = FirebaseAuth.instance.currentUser?.email;

  // Check if the user is authenticated
  if (currentUserEmail != null) {
    // Query the Users collection based on the email field
    QuerySnapshot querySnapshot = await _db
        .collection("Users")
        .where("email", isEqualTo: currentUserEmail)
        .get();

    // Check if a document with the specified email exists
    if (querySnapshot.docs.isNotEmpty) {
      // Get the document reference
      DocumentReference documentReference = querySnapshot.docs.first.reference;

      // Update the document
      await documentReference.update(user.toJson());

      Get.snackbar('Success', 'Info has been updated',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.greenAccent.withOpacity(0.2),
          colorText: Colors.black87);
    } else {
      // Handle the case when no document is found
      Get.snackbar('Error', 'User document not found',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent.withOpacity(0.2),
          colorText: Colors.black);
    }
  } else {
    // Handle the case when the user is not authenticated
    Get.snackbar('Error', 'User not authenticated',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent.withOpacity(0.2),
        colorText: Colors.black);
  }
}

  Future<UserData> getUserData(String email) async {
    final snapshot =
        await _db.collection('Users').where('email', isEqualTo: email).get();
    final userdetails =
        snapshot.docs.map((e) => UserData.fromSnapshot(e)).single;

    return userdetails;
  }

  Future<List<UserData>> allUser() async {
    final snapshot = await _db.collection('Users').get();
    final userdetails =
        snapshot.docs.map((e) => UserData.fromSnapshot(e)).toList();
    return userdetails;
  }
}

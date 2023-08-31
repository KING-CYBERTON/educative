import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GetAuth extends GetxController {
  static GetAuth instance = Get.find();

  //late Rx<User?> _user;
  Rxn<User> fbUser = Rxn<User>();
  GoogleSignIn googleSignIn = GoogleSignIn();
  

  FirebaseAuth auth = FirebaseAuth.instance;
  
  GoogleSignInAccount? _googleAcc;

  @override
  void onReady() {
    super.onReady();

    fbUser = Rxn<User>(auth.currentUser);
    

    fbUser.bindStream(auth.userChanges());

    ever(fbUser, _initialScreen);
  }

  _initialScreen(User? user) {
    if (user == null) {
      print('loged in');
      Get.offAllNamed('/login');
    } else {
      print(user.uid);
      Get.offAllNamed('/Response');
    }
  }

  void createUser(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      // we will display the message uing the getx snack bar
      print(e.toString());

      Get.snackbar(
        "user info",
        "user message",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        titleText: const Text(
          "account creation failed",
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }

  void logInUser(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      // we will display the message uing the getx snack bar
      print(e.toString());

      Get.snackbar(
        "user info",
        "user message",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        titleText: const Text(
          "account Login failed",
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // User canceled the sign-in process
        return;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        // Successful sign-in
        print('Signed in with Google: ${user.displayName}');
        // You can perform additional operations here, like storing user data, navigating to a new screen, etc.
      }
    } catch (e) {
      print('Google sign-in error: $e');
      // Handle sign-in error
    }
  }

  void resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      // Password reset email sent successfully
      Get.snackbar(
        "Reset Password",
        "Password reset email sent",
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.TOP,
        titleText: const Text(
          "Success",
          style: TextStyle(color: Colors.white),
        ),
      );
    } catch (e) {
      print(e.toString());
      // Handle password reset error
      Get.snackbar(
        "Reset Password",
        "Failed to send reset email",
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.TOP,
        titleText: const Text(
          "Error",
          style: TextStyle(color: Colors.white),
        ),
      );
    }
  }

  void logOut() {
    auth.signOut();
  }
}

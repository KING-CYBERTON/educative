import 'package:educative/Views/Splash.dart';
import 'package:educative/Views/welcome.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:educative/Views/Login.dart';
import 'package:educative/Views/Profile.dart';
import 'package:educative/Views/SignUp.dart';
import 'package:educative/controllers/AuthController.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await GoogleSignIn().signInSilently();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAmOB_-8DIEIwJEOvrM2a8C6RE-KbvSDDc",
          projectId: "educative-9",
          storageBucket: "educative-9.appspot.com",
          messagingSenderId: "14205101883",
          appId: "1:14205101883:web:7c0db5d88bc2dc0310791e"),
    ).then((value) => Get.put(GetAuth()));
    runApp(const MyApp());
  } else {
    await GoogleSignIn().signInSilently();
    await Firebase.initializeApp().then((value) => Get.put(GetAuth()));
    runApp(const MyApp());
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Tree Life',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => const LoginInPage()),
        GetPage(name: '/signup', page: () => const SignUpPage()),
        GetPage(name: '/Profile', page: () => UserProfileScreen()),
        GetPage(name: '/Welcome', page: () => WelcomePage()),
      ],
      initialRoute: '/',
    );
  }
}

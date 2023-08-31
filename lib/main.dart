import 'package:educative/Homeviews/add_post.dart';
import 'package:educative/Homeviews/homepage.dart';
import 'package:educative/LoginViews/Splash.dart';
import 'package:educative/LoginViews/welcome.dart';
import 'package:educative/Profileview/Form.dart';
import 'package:educative/ResponsiveUI/mobile.dart';
import 'package:educative/ResponsiveUI/response.dart';
import 'package:educative/ResponsiveUI/webview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:educative/LoginViews/Login.dart';
import 'package:educative/Profileview/Profile.dart';
import 'package:educative/LoginViews/SignUp.dart';
import 'package:educative/controllers/AuthController.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'ResponsiveUI/Tabletscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await GoogleSignIn().signInSilently();
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyAmOB_-8DIEIwJEOvrM2a8C6RE-KbvSDDc",
          projectId: "educative-9",
          storageBucket: "educative-9.appspot.com",
          databaseURL: "https://educative-9-default-rtdb.firebaseio.com",
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
         GetPage(name: '/Addpost', page: () => const AddPost()),
        GetPage(name: '/Form', page: () => const ProfileTab()),
        GetPage(
            name: '/Homepage',
            page: () => const HomePage(
                  selectedIndex: 0,
                )),
       
        GetPage(
            name: '/Response',
            page: () => const ResponsiveLayout(
                mobileScreenLayout: mobilescreenlayout(),
                webScreenLayout: weblcreenlayout(),
                tabletScreenLayout: tabletscreeen()
                )),
      ],
      initialRoute: '/',
    );
  }
}

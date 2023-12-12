import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:educative/Constraits/CustomText.dart';
import 'package:get/get.dart';
import 'package:educative/controllers/AuthController.dart';

// import 'package:panda_period/auth/GetAuth.dart';

class LoginInPage extends StatefulWidget {
  const LoginInPage({super.key});

  @override
  State<LoginInPage> createState() => _LoginInPageState();
}

class _LoginInPageState extends State<LoginInPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    //GetAuth controller = Get.put(GetAuth());
    return Scaffold(
        resizeToAvoidBottomInset: false,
     
        body: SafeArea(
            child: Center(
          child: Container(
            width: 350,
            height: 600,
            decoration: BoxDecoration(
              image: const DecorationImage(
                  image: AssetImage("assets/images/Splash.jpg"),
                  fit: BoxFit.fill),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 10,
                  offset: Offset(1, 1),
                  color: Colors.greenAccent,
                )
              ],
              border: Border.all(
                color:  Colors.greenAccent,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(11),
            ),
            child: Center(
              child: Column(children: [
                Container(
                  child: Image.asset(
                    'assets/images/logo.png',
                  ),
                ),

                const Text(
                  'Welcome',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.lightGreenAccent,
                  ),
                ),
                const SizedBox(height: 40),
                // ignore: prefer_const_constructors
                CustomText(
                  hintText: 'Enter your email',
                  textInputType: TextInputType.emailAddress,
                  isPass: false,
                  textController: emailController,
                ),
                const SizedBox(height: 20),
                // ignore: prefer_const_constructors
                CustomText(
                  hintText: 'Enter your password',
                  textInputType: TextInputType.emailAddress,
                  isPass: true,
                  textController: passwordController,
                ),
                const SizedBox(height: 20),

                const SizedBox(
                  width: 90,
                ),
                ElevatedButton(
                  onPressed: () {
                    GetAuth.instance.logInUser(emailController.text.trim(),
                        passwordController.text.trim());
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white10,
                    shadowColor: Color.fromARGB(26, 81, 160, 180),
                  ),
                  child: Text(
                    'Log In',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xffea1857),
                    ),
                  ),
                ),

                const SizedBox(width: 60),
                const SizedBox(height: 20),
                Wrap(
                  children: [
                    RichText(
                        text: TextSpan(
                      text: "Don't have an account?",
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(
                            text: ' SignUp',
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.toNamed('/signup');
                              })
                      ],
                    )),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    GetAuth.instance.signInWithGoogle();
                  },
                  child: const CircleAvatar(
                    backgroundColor: Colors.white10,
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/google.png'),
                  ),
                ),
                Wrap(
                  children: [
                    RichText(
                        text: TextSpan(
                      text: "Forgotten password?",
                      style: const TextStyle(
                        color: Colors.grey,
                      ),
                      children: [
                        TextSpan(
                            text: 'RECOVER',
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                GetAuth.instance
                                    .resetPassword(emailController.text.trim());
                              })
                      ],
                    )),
                  ],
                ),
              ]),
            ),
          ),
        )));
  }
}

// ignore_for_file: unused_element

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Datamodels/UserModel.dart';
import '../controllers/FstoreConroller.dart';
// ignore_for_file: unused_element

class ProfileTab extends StatefulWidget {
  const ProfileTab({Key? key}) : super(key: key);

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late DateTime selectedDate;
  final _formKey = GlobalKey<FormState>();
  final _UsernameController = TextEditingController();
  final _AgeController = TextEditingController();
  final _RegionController = TextEditingController();
  final _NTPController = TextEditingController();
  final _BioController = TextEditingController();
  final controller = Get.put(FireRepo());

  final bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    String? emailValidator(String? value) {
      if (value == null || value.isEmpty) {
        return 'Email is required';
      }
      final emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,}$');
      if (!emailRegExp.hasMatch(value)) {
        return 'Invalid email address';
      }
      return null;
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.greenAccent[200],
          titleSpacing: 0.0,
          centerTitle: true,
          toolbarHeight: 65.2,
          toolbarOpacity: 0.8,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(25),
              bottomLeft: Radius.circular(25),
            ),
          ),
        title: const Text('Profile'),
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
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
              color: Colors.greenAccent,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(11),
          ),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Center(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(height: 20.0),
                      const Text(
                        'Profile',
                        style: TextStyle(
                            color: Colors.greenAccent,
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        width: 300,
                        child: TextFormField(
                          controller: _UsernameController,
                          decoration: const InputDecoration(
                            fillColor: Colors.white,
                            labelText: 'UserName',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your Username';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        width: 300,
                        child: TextFormField(
                          controller: _AgeController,
                          decoration: const InputDecoration(
                            labelText: 'Age',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a you age';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        width: 300,
                        child: TextFormField(
                          controller: _RegionController,
                          decoration: const InputDecoration(
                            labelText: 'Enter your region',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your region';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        width: 300,
                        child: TextFormField(
                          controller: _NTPController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'No of trees planted',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your NO of trees';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        width: 300,
                        child: TextFormField(
                          controller: _BioController,
                          decoration: const InputDecoration(
                            labelText: 'Enter Bio data',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a Bio data';
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      ElevatedButton(
                        onPressed: () {
                          if (!_formKey.currentState!.validate()) return;

                          final email =
                              FirebaseAuth.instance.currentUser?.email;
                          final user = UserData(
                            email: email.toString(),
                            username: _UsernameController.text.trim(),
                            age: int.parse(_AgeController.text.trim()),
                            no_of_trees: int.parse(_NTPController.text.trim()),
                            region: _RegionController.text.trim(),
                            biography: _BioController.text.trim(),
                          );

                          controller.createUser(user);
                        },
                        child: const Text('Save'),
                      ),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

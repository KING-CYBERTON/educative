import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Datamodels/UserModel.dart';
import '../controllers/AuthController.dart';
import '../controllers/FstoreConroller.dart';

class ProfileEditTab extends StatefulWidget {
  const ProfileEditTab({super.key});

  @override
  _ProfileEditTabState createState() => _ProfileEditTabState();
}

class _ProfileEditTabState extends State<ProfileEditTab> {
  late Future<UserData> _userDataFuture;
  final repo = Get.put(FireRepo());
  final _formKey = GlobalKey<FormState>();
  final _UsernameController = TextEditingController();
  final _AgeController = TextEditingController(text: "");
  final _RegionController = TextEditingController();
  final _NTPController = TextEditingController();
  final _BioController = TextEditingController();
  final controller = Get.put(FireRepo());

  final email = FirebaseAuth.instance.currentUser?.email;

  @override
  void initState() {
    super.initState();
    _userDataFuture = FireRepo.instance.getUserData(email.toString());
  
  }

  @override
  Widget build(BuildContext context) {
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
          title: const Text(
            'Account Profile',
            style: TextStyle(fontStyle: FontStyle.italic),
          ),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
              onPressed: () {
                Get.toNamed('/Form');
              },
            ),
          ]),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
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
          child: FutureBuilder<UserData>(
            future: _userDataFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final userData = snapshot.data!;
                return Center(
                  child: Container(
                    height: 600,
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
                                    initialValue: userData.email,
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
                                    initialValue: userData.age.toString(),
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
                                    initialValue: userData.region,
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
                                    initialValue:
                                        userData.no_of_trees.toString(),
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
                                    initialValue: userData.biography,
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
                                    if (!_formKey.currentState!.validate()) ;

                                    final email = FirebaseAuth
                                        .instance.currentUser?.email;
                                    final user = UserData(
                                      email: email.toString(),
                                      username: _UsernameController.text.trim(),
                                      age:
                                          int.parse(_AgeController.text.trim()),
                                      no_of_trees:
                                          int.parse(_NTPController.text.trim()),
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
                );
              } else if (snapshot.hasError) {
                print(snapshot.error.toString());
                return Center(
                  child: Container(
                    child: Center(
                      child: Container(
                        width: 300,
                        color: Colors.white24.withOpacity(0.5),
                        child: const Text(
                          "Welcome to tree life\n Please fill your profile details to continue ",
                          style: TextStyle(
                              color: Color.fromARGB(255, 10, 10, 10),
                              fontStyle: FontStyle.italic,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}

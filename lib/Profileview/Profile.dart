import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Datamodels/UserModel.dart';
import '../controllers/AuthController.dart';
import '../controllers/FstoreConroller.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  late Future<UserData> _userDataFuture;
  final repo = Get.put(FireRepo());
  late bool edit = false;
  final TextEditingController _UsernameController = TextEditingController();
  final TextEditingController _AgeController = TextEditingController();
  final TextEditingController _RegionController = TextEditingController();
  final TextEditingController _NTPController = TextEditingController();
  final TextEditingController _BioController = TextEditingController();
  final email = FirebaseAuth.instance.currentUser?.email;

  @override
  void initState() {
    super.initState();
    _userDataFuture = FireRepo.instance.getUserData(email.toString());
    @override
    void initState() {
      super.initState();
      _userDataFuture = FireRepo.instance.getUserData(email.toString());
    }
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
                  child: SizedBox(
                    height: 600,
                    child: SingleChildScrollView(
                      child: edit
                          ? Column(children: [
                              const SizedBox(height: 20.0),
                              const CircleAvatar(
                                radius: 100,
                                backgroundColor: Colors.transparent,
                                backgroundImage:
                                    AssetImage('assets/images/logo.png'),
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
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      final email = FirebaseAuth
                                          .instance.currentUser?.email;
                                      final user = UserData(
                                        email: email.toString(),
                                        username:
                                            _UsernameController.text.trim(),
                                        age: int.parse(
                                            _AgeController.text.trim()),
                                        no_of_trees: int.parse(
                                            _NTPController.text.trim()),
                                        region: _RegionController.text.trim(),
                                        biography: _BioController.text.trim(),
                                      );
                                      print(userData.id);
                                      repo.editUser(user);
                                    },
                                    child: const Text('Save'),
                                  ),
                                  SizedBox(width: 20),
                                  ElevatedButton(
                                    onPressed: () {
                                      setState(() {
                                        edit = false;
                                      });
                                    },
                                    child: const Text('Back'),
                                  ),
                                ],
                              ),
                            ])
                          : Column(
                              children: [
                                const SizedBox(height: 30),
                                const CircleAvatar(
                                  radius: 100,
                                  backgroundColor: Colors.transparent,
                                  backgroundImage:
                                      AssetImage('assets/images/logo.png'),
                                ),
                                Container(
                                  width: 300,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 46, 75, 61)
                                        .withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    userData.username,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  width: 300,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 46, 75, 61)
                                        .withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    "Biograpy: ${userData.biography}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  width: 300,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(255, 46, 75, 61)
                                        .withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.5),
                                        spreadRadius: 2,
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  padding: const EdgeInsets.all(10),
                                  child: Text(
                                    "Region:  ${userData.region}",
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontStyle: FontStyle.italic,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Center(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        width: 300,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                                  255, 46, 75, 61)
                                              .withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          "Age: ${userData.age}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Container(
                                        width: 300,
                                        decoration: BoxDecoration(
                                          color: const Color.fromARGB(
                                                  255, 46, 75, 61)
                                              .withOpacity(0.5),
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.5),
                                              spreadRadius: 2,
                                              blurRadius: 5,
                                              offset: const Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          "no_of_trees: ${userData.no_of_trees}",
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        GetAuth.instance.logOut();
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.red,
                                        shadowColor: const Color.fromARGB(
                                            26, 81, 160, 180),
                                      ),
                                      child: Text(
                                        'Log out',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.lightGreen[800],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        setState(() {
                                          _UsernameController.text =
                                              userData.username;
                                          _AgeController.text =
                                              userData.age.toString();
                                          _RegionController.text =
                                              userData.region;
                                          _NTPController.text =
                                              userData.no_of_trees.toString();
                                          _BioController.text =
                                              userData.biography;
                                          edit = true;
                                        });
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.blue[200],
                                        shadowColor: const Color.fromARGB(
                                            26, 81, 160, 180),
                                      ),
                                      child: Text(
                                        'Edit',
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: Colors.lightGreen[800],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                              ],
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

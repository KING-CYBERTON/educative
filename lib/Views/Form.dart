// ignore_for_file: unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:educative/Constraits/UserModel.dart';
import 'package:educative/controllers/FstoreConroller.dart';

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

  bool _isLoading = false;

  final repo = Get.put(FireRepo());

  @override
  void initState() {
    super.initState();
    selectedDate = DateTime.now();
  }

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
        title: Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 20.0),
                const Text(
                  'Profile',
                  style: TextStyle(fontSize: 32.0, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _UsernameController,
                  decoration: const InputDecoration(
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
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _AgeController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20.0),
                TextFormField(
                  controller: _RegionController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: 'Period length (in days)',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your period length';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20.0),
                TextFormField(
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
                const SizedBox(height: 20.0),
                TextFormField(
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
                const SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    if (!_formKey.currentState!.validate()) return;

                    final uid = FirebaseAuth.instance.currentUser?.uid;
                    final user = UserData(
                      username: _UsernameController.text.trim(),
                      age: int.parse(_AgeController.text.trim()),
                      no_of_trees: int.parse(_NTPController.text.trim()),
                      region: _RegionController.text.trim(),
                      biography: _BioController.text.trim(),
                    );

                    FireRepo.instance.createUser(user);
                    Get.offAllNamed('/Homescreen');
                  },
                  child: const Text('Save'),
                ),
              ]),
        ),
      ),
    );
  }
}

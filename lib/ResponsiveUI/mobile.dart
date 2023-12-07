import 'dart:async';

import 'package:educative/Homeviews/add_post.dart';
import 'package:educative/Homeviews/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class mobilescreenlayout extends StatefulWidget {
  const mobilescreenlayout({super.key});

  @override
  State<mobilescreenlayout> createState() => _mobilescreenlayoutState();
}

// ignore: camel_case_types
class _mobilescreenlayoutState extends State<mobilescreenlayout> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent[200],
        titleSpacing: 0.0,
        centerTitle: true,
        toolbarHeight: 60.2,
        toolbarOpacity: 0.8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
        ),
        title: Image.asset(
          "images/logo.png",
          width: 90,
          height: 90.0,
        ),
        leading: IconButton(
            onPressed: () {
              Get.toNamed('/Profile');
            },
            icon: const Icon(Icons.person)),
        actions: const [],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Container(
              height: double.infinity,
              width: double.infinity,

              child: HomePage(selectedIndex: selectedIndex)),
        ),
      ),
      bottomNavigationBar: MyBottomNavigationBar(
        selectedIndex: selectedIndex,
        onIndexChanged: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
      resizeToAvoidBottomInset: false,
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FloatingActionButton(
            onPressed: () {
              //Get.toNamed('/Addpost');
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const AddPostDialog();
                },
              );
            },
            tooltip: 'Post',
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

import 'package:educative/Homeviews/homepage.dart';
import 'package:educative/ResponsiveUI/mobile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'response.dart';

// ignore: camel_case_types
class weblcreenlayout extends StatefulWidget {
  const weblcreenlayout({super.key});

  @override
  State<weblcreenlayout> createState() => _weblcreenlayoutState();
}

// ignore: camel_case_types
class _weblcreenlayoutState extends State<weblcreenlayout> {
  int selectedIndex = 0;
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
          title: Image.asset(
            "assets/images/logo.png",
            width: 14,
            height: 14.0,
          ),
          leading: IconButton(
              onPressed: () {
                Get.toNamed('/Profile');
              },
              icon: const Icon(Icons.person)),
          actions: [
            IconButton(
              onPressed: () {
                setState(() {
                  selectedIndex = 0;
                });
              },
              icon: const Icon(Icons.padding_outlined),
              color: selectedIndex == 0
                  ? Colors.lightBlueAccent[200]
                  : Colors.white,
              tooltip: 'Posts',
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  selectedIndex = 1;
                });
              },
              icon: const Icon(Icons.event_available),
              color: selectedIndex == 1
                  ? Colors.lightBlueAccent[200]
                  : Colors.white,
              tooltip: 'Events',
            ),
          ]),
      body: Stack(
        children: [
          Center(
            child: Container(
                color: Colors.white,
                height: double.infinity,
                width: MediaQuery.of(context).size.width * 0.8,
                child: HomePage(selectedIndex: selectedIndex)),
          ),
        ],
      ),
      resizeToAvoidBottomInset: true,
      floatingActionButton: Align(
        alignment: Alignment.bottomRight,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FloatingActionButton(
            onPressed: () {
              Get.toNamed('/Addpost');
            },
            tooltip: 'Post',
            child: const Icon(Icons.add),
          ),
        ),
      ),
    );
  }
}

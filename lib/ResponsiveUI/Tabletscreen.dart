import 'package:educative/Homeviews/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// ignore: camel_case_types
class tabletscreeen extends StatefulWidget {
  const tabletscreeen({super.key});

  @override
  State<tabletscreeen> createState() => _tabletscreeenState();
}

// ignore: camel_case_types
class _tabletscreeenState extends State<tabletscreeen> {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Center(
              child: Container(
                  
                  height: double.infinity,
                  width: MediaQuery.of(context).size.width * 0.8,
                    decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/Splash.jpg"),
                        fit: BoxFit.fill),
                    color: Colors.white,),
                  child: HomePage(selectedIndex: selectedIndex)
                  ),
            ),
          ],
        ),
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

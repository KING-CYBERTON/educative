import 'package:educative/Homeviews/events.dart';
import 'package:educative/Homeviews/post.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Homeviews/add_post.dart';

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
          width: 90,
          height: 90.0,
        ),
        leading: IconButton(
            onPressed: () {
              Get.toNamed('/Profile');
            },
            icon: const Icon(Icons.person)),
      ),
      body: Stack(
        children: [
          Center(
            child: Container(
                height: double.infinity,
                width: MediaQuery.of(context).size.width * 0.8,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/images/Splash.jpg"),
                      fit: BoxFit.fill),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          Container(
                            width: double.maxFinite,
                            color: Colors.black,
                            child: const SizedBox(
                              height: 20,
                              child: Text(
                                'Forum Feeds',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: PostList(),
                          )),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            color: Colors.black,
                            width: double.infinity,
                            child: const SizedBox(
                              height: 20,
                              child: Text(
                                'Events',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontStyle: FontStyle.italic,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: EventList(),
                          )),
                        ],
                      ),
                    ),
                  ],
                )),
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

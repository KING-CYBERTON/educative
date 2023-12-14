import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/realtime_coontoller.dart';

class PostCard extends StatelessWidget {
  final Map post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    final Realtime controller = Get.find();
    if (post['photo'] == null) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.greenAccent,
                width: 3,
              ),
              color: Colors.white.withOpacity(0.9)),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.all(0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      child: Icon(Icons.person),
                    )
                  ],
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      width: 300,
                      color: Colors.white,
                      child: Text(post['captions']),
                    ),
                    Align(
                      alignment: Alignment.topRight,
                      child: IconButton(
                          onPressed: () {
                            String eventId = post['key'];
                            String dataNode = 'Post';
                            controller.deleteEvent(dataNode, eventId);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          )),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: Container(
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: Colors.greenAccent,
                width: 3,
              ),
              color: Colors.white.withOpacity(0.5)),
          child: Stack(
            children: [
              Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.all(0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          child: Icon(Icons.person),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Container(
                      child: Column(
                        children: [
                          Container(
                            width: 300,
                            color: Colors.white,
                            child: Text(post['captions']),
                          ),
                          Container(
                              width: 300,
                              height: 200,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage(
                                      post['photo'],
                                    )),
                              )),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () {
                      String eventId = post['key'];
                      String dataNode = 'Post';
                      controller.deleteEvent(dataNode, eventId);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    )),
              ),
            ],
          ),
        ),
      );
    }
  }
}

class PostList extends StatelessWidget {
  PostList({super.key});
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    Query sortingBychild = _database.child('Post').orderByChild('photo');
    Query sortingbyvalue = _database.child('Post').orderByValue();
    Query sortingbyKey = _database.child('Post').orderByKey();

    return FirebaseAnimatedList(
        query: sortingbyKey,
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map Post = snapshot.value as Map;
          Post['key'] = snapshot.key;

          return PostCard(post: Post);
        });
  }
}

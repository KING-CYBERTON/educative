import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import '../Datamodels/event_model.dart';


class PostCard extends StatelessWidget {
  final Map post;
  const PostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    if (post['photo'] == null) {
      return Container(
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.greenAccent,
            width: 3,
          ),
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('images/splash.jpg'),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    width: 300,
                    child: Text(post['captions']),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    } else {
      return Container(
        width: 300,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.greenAccent,
            width: 3,
          ),
        ),
        child: Row(
          children: [
            const Padding(
              padding: EdgeInsets.all(0.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage('images/splash.jpg'),
                  )
                ],
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    width: 300,
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
          ],
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
    Query sortingBychild = _database.child('posts').orderByChild('photo');
     Query sortingbyvalue= _database.child('posts').orderByValue();
      Query sortingbyKey = _database.child('posts').orderByKey();

    return FirebaseAnimatedList(
        query: _database.child('posts'),
       
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map Post = snapshot.value as Map;
          Post['key'] = snapshot.key;

          return PostCard(post: Post);
        });
  }
}

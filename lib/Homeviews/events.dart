import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import '../Datamodels/event_model.dart';

class EventCard extends StatelessWidget {
  final Map event;
  const EventCard({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: Stack(children: [
        Container(
          width: double.infinity,
          height: 200,
          decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  blurRadius: 10,
                  offset: Offset(1, 1),
                  color: Color.fromARGB(255, 12, 194, 82),
                )
              ],
              border: Border.all(
                color: const Color.fromARGB(255, 60, 206, 16),
                width: 2,
              ),
              image: DecorationImage(
                image: AssetImage(
                  event['eventimage'],
                ),
                fit: BoxFit.fitWidth,
              ),
              borderRadius: BorderRadius.circular(16.0),
              color: Colors.white),
        ),
        Align(
          alignment: Alignment.center,
          child: SizedBox(
            height: 200,
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 150,
                  ),
                  Container(
                    color: Colors.white10.withOpacity(0.6),
                    child: Column(
                      children: [
                        Text(
                          event['eventdetails'],
                          style: const TextStyle(color: Colors.black),
                        ),
                        Text(event['eventtitle'],
                            style: const TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                ]),
          ),
        ),
      ]),
    );
  }
}

class EventList extends StatelessWidget {
  EventList({super.key});
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  @override
  Widget build(BuildContext context) {
    Query sortingBychild = _database.child('Events').orderByChild('photo');
    Query sortingbyvalue = _database.child('Events').orderByValue();
    Query sortingbyKey = _database.child('Events').orderByKey();
    return FirebaseAnimatedList(
        query: sortingBychild.limitToLast(10),
        itemBuilder: (BuildContext context, DataSnapshot snapshot,
            Animation<double> animation, int index) {
          Map Event = snapshot.value as Map;
          Event['key'] = snapshot.key;

          return EventCard(event: Event);
        });
  }
}

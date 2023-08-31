import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/realtime_coontoller.dart';
import '../Datamodels/event_model.dart';
import 'events.dart';
import 'post.dart';

class HomePage extends StatefulWidget {
  final int selectedIndex;
  const HomePage({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> eventToMap(Event event) {
    return {
      'userid': event.userid,
      'eventtitle': event.eventtitle,
      'eventdetails': event.eventdetails,
      'eventimage': event.eventimage,
    };
  }

  void Eventspost() {
    List<Event> events = [
      Event(
          userid: 'kimani',
          eventtitle: 'treeplanting',
          eventdetails: 'save the world',
          eventimage: 'images/tree.jpg'),
      Event(
          userid: 'John',
          eventtitle: 'Watering trees',
          eventdetails: 'Watering seedlings from the last tree planting event',
          eventimage: 'images/tree.jpg'),
      Event(
          userid: 'kaleb',
          eventtitle: 'treeplanting3',
          eventdetails: 'save the world3',
          eventimage: 'images/tree.jpg'),
    ];

    for (var i = 0; i < events.length; i++) {
      DatabaseReference eventsref =
          FirebaseDatabase.instance.ref().child('Event');

      // Use push method to generate a unique key for each event
      var newEventRef = eventsref.push();

      // Set the event data as a child of the unique key
      newEventRef.update(eventToMap(events[i]));
    }
  }

  @override
  void initState() {
    super.initState();

    Eventspost();
  }

  bool showFeedButton = false;
  bool showEventsButton = false;

  final real = Get.put(Realtime());

  @override
  Widget build(BuildContext context) {
    int selectedIndex = widget.selectedIndex;
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: Container(
                color: Colors.white10,
                child: Stack(
                  children: [
                    selectedIndex == 0 ? PostList() : EventList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onIndexChanged;

  const MyBottomNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.onIndexChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: Colors.greenAccent,
          width: 3,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onIndexChanged(0),
              child: Container(
                constraints: const BoxConstraints(
                    maxWidth:
                        150), // Limit width to half of the available space
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: [
                    BoxShadow(
                      color: selectedIndex == 0
                          ? Colors.greenAccent.withOpacity(0.5)
                          : Colors.white.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  border: Border.all(
                    color: selectedIndex == 1
                        ? Colors.transparent
                        : Colors.greenAccent,
                    width: 3,
                  ),
                ),
                child: const Center(
                  child: Text('Forum'),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onIndexChanged(1),
              child: Container(
                constraints: const BoxConstraints(
                    maxWidth:
                        150), // Limit width to half of the available space
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                  boxShadow: [
                    BoxShadow(
                      color: selectedIndex == 1
                          ? Colors.greenAccent.withOpacity(0.5)
                          : Colors.white.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  border: Border.all(
                    color: selectedIndex == 0
                        ? Colors.transparent
                        : Colors.greenAccent,
                    width: 3,
                  ),
                ),
                child: const Center(
                  child: Text('Events'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


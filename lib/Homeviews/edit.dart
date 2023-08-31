import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../controllers/realtime_coontoller.dart';

class EditEventPage extends StatefulWidget {
  final Map event;
  EditEventPage({required this.event});

  @override
  _EditEventPageState createState() => _EditEventPageState();
}

class _EditEventPageState extends State<EditEventPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _detailsController = TextEditingController();
  final captioncontroller = TextEditingController();
  String? userid = FirebaseAuth.instance.currentUser?.uid;
  File? _imageFile;
  XFile? file;
  final Realtime controller = Get.find();

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.event['eventtitle'];
    _detailsController.text = widget.event['eventdetails'];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Event Title'),
            ),
            TextFormField(
              controller: _detailsController,
              decoration: InputDecoration(labelText: 'Event Details'),
            ),
            // Add other form fields or widgets here
            ElevatedButton(
              onPressed: () {
                controller.editevent(userid!, file, _titleController.text,
                    widget.event['key'], _detailsController.text, 'Event');

                Navigator.pop(context);
              },
              child: Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}

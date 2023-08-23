import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Constraits/CustomText.dart';
import '../controllers/StorageController.dart';
import '../controllers/realtime_coontoller.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

String dropdownValue = 'Select';

class _AddPostState extends State<AddPost> {
  final Realtime controller = Get.find();
  final captioncontroller = TextEditingController();
  String userid = 'kimani';
  File? _imageFile;
  XFile? file;
  Future<void> _pickImage() async {
    final picker = ImagePicker();

    file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      setState(() {
        _imageFile = File(file!.path);
      });
    }
  }

  late String photo = '';
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
        title: const CircleAvatar(
          backgroundImage: AssetImage('images/splash.jpg'),
        ),
      ),
      body: Center(
        child: Container(
          width: 300,
          height: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.greenAccent,
              width: 3,
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  CustomText(
                      isPass: false,
                      hintText: 'Enter captions',
                      textInputType: TextInputType.text,
                      textController: captioncontroller),
                  const SizedBox(
                    height: 30,
                  ),

                  //should be a list of selected photos
                  GestureDetector(
                    onTap: () {
                      _pickImage();
                    },
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: _imageFile != null
                          ? kIsWeb
                              ? Image.network(_imageFile!.path)
                              : Image.file(_imageFile!)
                          : const Center(
                              child: Text('Press to select image'),
                            ),
                    ),
                  ),

                  const SizedBox(height: 20),
                  DropdownButton<String>(
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['Select', 'Post', 'Event']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        String captions = captioncontroller.text.trim();
                        if (file != null) {
                          controller.addPost(userid,file, captions);
                        } else {
                          controller.addPost2(userid, captions);
                        }
                      },
                      child: const Text('Publish'))
                ]),
          ),
        ),
      ),
    );
  }
}

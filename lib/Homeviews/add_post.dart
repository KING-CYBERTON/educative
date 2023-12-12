import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../Constraits/CustomText.dart';
import '../controllers/realtime_coontoller.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class AddPost extends StatefulWidget {
  const AddPost({super.key});

  @override
  State<AddPost> createState() => _AddPostState();
}

String dropdownValue = 'Post';

class _AddPostState extends State<AddPost> {
  final Realtime controller = Get.find();
  final captioncontroller = TextEditingController();
  String? userid = FirebaseAuth.instance.currentUser?.uid;
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
          backgroundImage: AssetImage('assets/images/splash.jpg'),
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

                        if (captions.isNotEmpty) {
                          if (file != null) {
                            controller.addPost(
                                userid!, file, captions, dropdownValue);
                          } else {
                            controller.addPost2(
                                userid!, captions, dropdownValue);
                          }
                        } else {
                          Get.snackbar(
                            'Error',
                            'Please add a caption',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.redAccent.withOpacity(0.2),
                            colorText: Colors.black,
                          );
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

class AddPostDialog extends StatefulWidget {
  const AddPostDialog({Key? key}) : super(key: key);

  @override
  State<AddPostDialog> createState() => _AddPostDialogState();
}

class _AddPostDialogState extends State<AddPostDialog> {
  final Realtime controller = Get.find();
  final captioncontroller = TextEditingController();
  String? userid = FirebaseAuth.instance.currentUser?.uid;
  final titleController = TextEditingController();
  final detailsController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.6,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButton<String>(
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <String>['Post', 'Event']
                        .map<DropdownMenuItem<String>>(
                          (String value) => DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          ),
                        )
                        .toList(),
                  ),
                  if (dropdownValue == 'Event') ...[
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                        hintText: 'Event Title',
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: detailsController,
                      decoration: const InputDecoration(
                        hintText: 'Event Details',
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        _pickImage();
                      },
                      child: _imageFile != null
                          ? Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                              child: kIsWeb
                                  ? Image.network(_imageFile!.path)
                                  : Image.file(_imageFile!))
                          : const Icon(Icons.camera_enhance),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        String title = titleController.text.trim();
                        String details = detailsController.text.trim();
              
                          controller.addevent(
                              userid!, file, title, details, dropdownValue);

                          Navigator.of(context).pop();
                       
                      },
                      child: const Text('Publish'),
                    ),
                    const SizedBox(height: 20),
                  ] else ...[
                    const SizedBox(height: 20),
                    TextField(
                      controller: captioncontroller,
                      decoration: const InputDecoration(
                        hintText: 'Enter captions',
                      ),
                    ),
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: () {
                        _pickImage();
                      },
                      child: _imageFile != null
                          ? Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                              ),
                              child: kIsWeb
                                  ? Image.network(_imageFile!.path)
                                  : Image.file(_imageFile!))
                          : const Icon(Icons.camera_enhance),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        String captions = captioncontroller.text.trim();
                        if (captions.isNotEmpty) {
                          if (file != null) {
                            controller.addPost(
                                userid!, file, captions, dropdownValue);
                            Navigator.of(context).pop();
                          } else {
                            controller.addPost2(
                                userid!, captions, dropdownValue);
                            Navigator.of(context).pop();
                          }
                        } else {
                          Get.snackbar(
                            'Error',
                            'Please add a caption',
                            snackPosition: SnackPosition.TOP,
                            backgroundColor: Colors.redAccent.withOpacity(0.5),
                            colorText: Colors.black,
                          );
                        }
                      },
                      child: const Text('Publish'),
                    ),
                    const SizedBox(height: 20),
                  ]
                ]),
          ),
        ),
      ),
    );
  }
}

void showAddPostDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const AddPostDialog();
    },
  );
}

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';


class Realtime extends GetxController {
  static Realtime instance = Get.find();
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
    Reference referenceDirImage = FirebaseStorage.instance.ref().child('imagestest');

  late String imageUrl;


    void addPost2(String userId, String captions) async {
    try {
        Map<String, dynamic> postData = {
          
        'userid': userId,
        'captions': captions,
      };
      await _database.child('posts').push().set(postData).then((_) {
        Get.snackbar(
          'Success',
          'Info has been updated',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.greenAccent.withOpacity(0.2),
          colorText: Colors.black87,
        );
      }).catchError((e) {
        Get.snackbar(
          'Error',
          'Something went wrong',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent.withOpacity(0.2),
          colorText: Colors.black,
        );
      });
    } catch (e) {
      print('Error adding post: $e');
    }
  }

  void addPost(String userId,XFile? file, String captions) async {
        if (file == null) return;
    //step 4 create unique name for image
    String imageName = DateTime.now().microsecondsSinceEpoch.toString();

    //steep two is to upload the image.
    //import storage libray
    //to ipload we need a reference of the file and to do that we need to create the reference

    //create a reference for the specific file we are uploading
    Reference referenceImagetoUpload = referenceDirImage.child(imageName);

    try {
      if (kIsWeb) {
           await referenceImagetoUpload
         .putData(
      await file.readAsBytes(),
      SettableMetadata(contentType: 'image/jpeg'),
    )
          .whenComplete(() => {
                imageUrl = referenceImagetoUpload.getDownloadURL().toString(),
                print('this is the url  $imageUrl'),
              });
      //if succesfull get url
      imageUrl = await referenceImagetoUpload.getDownloadURL();
      print('this is the url$imageUrl');
} else { 
       await referenceImagetoUpload
      .putFile(File(file.path))
      .whenComplete(() => {
            imageUrl = referenceImagetoUpload.getDownloadURL().toString(),
            print('this is the url$imageUrl'),
          });
  //if succesfull get url
  imageUrl = await referenceImagetoUpload.getDownloadURL();
  print('this is the url$imageUrl');
}
    } catch (e) {
      print(e.toString());
    }
    
    try {
        Map<String, dynamic> postData = {
          
        'userid': userId,
        'captions': captions,
        'photo': imageUrl,
      };
      await _database.child('posts').push().set(postData).then((_) {
        Get.snackbar(
          'Success',
          'Info has been updated',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.greenAccent.withOpacity(0.2),
          colorText: Colors.black87,
        );
      }).catchError((e) {
        Get.snackbar(
          'Error',
          'Something went wrong',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent.withOpacity(0.2),
          colorText: Colors.black,
        );
      });
    } catch (e) {
      print('Error adding post: $e');
    }
  }


}

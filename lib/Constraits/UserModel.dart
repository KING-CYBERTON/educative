import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  String? id;
  String region;
  String username;
  int age;
  String biography;
  int no_of_trees;

  UserData({
    this.id,
    required this.username,
    required this.age,
    required this.biography,
    required this.no_of_trees,
    required this.region,
  });

  toJson() {
    return {
      'username': username,
      'age': age,
      'biography': biography,
      'no_of_trees': no_of_trees,
      'region': region,
    };
  }

  factory UserData.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final json = document.data();
    return UserData(
      id: document.id,
      username: json!['name'],
      region: json!['region'],
      age: json['age'],
      biography: json['biography'],
      no_of_trees: json['no_of_trees'],
    );
  }
}

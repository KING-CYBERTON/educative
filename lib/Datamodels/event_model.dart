// ignore: file_names
class Event {
  String userid;
  String eventtitle;
  String eventdetails;
  String eventimage; //url for the image

  Event({
    required this.userid,
    required this.eventtitle,
    required this.eventdetails,
    required this.eventimage,
  });
 

  static List<Event> events = [
    Event(
        userid: 'kimani', 
        eventtitle: 'treeplanting',
        eventdetails: 'save the world',
        eventimage: 'images/tree.jpg'),
    Event(
        userid: 'kimani2',
        eventtitle: 'treeplanting2',
        eventdetails: 'save the world2',
        eventimage: 'images/tree.jpg'),
    Event(
        userid: 'kimani3',
        eventtitle: 'treeplanting3',
        eventdetails: 'save the world3',
        eventimage: 'images/tree.jpg'),
  ];
}

class Post {
  String userid;
  String? photo;
  String captions;

  Post({
    required this.userid,
    this.photo,
    required this.captions,
  });


  Map<String, dynamic> toJson() {
    return {
      'userid': userid,
      'photo': photo,
      'captions': captions   
    };
  }

  static List<Post> posts = [
    Post(userid: 'Wambui', captions: 'Lets make it green'),
    Post(
        userid: 'Wambui2',
        captions: 'Lets make it green',
        photo: 'images/logo.png'),
    Post(userid: 'Wambui3', captions: 'World wide ecosystem')
  ];
}

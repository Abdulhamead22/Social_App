class PostModel {
   final String name;
  final  String dateTime;
  final  String uId;
  // final  String postId;

  final  String image;
  final  String text;
  final  String postImage;

  PostModel(
     {
    required this.name,
    required this.dateTime,
    required this.image,
    required this.text,
    required this.postImage,
    required this.uId,
    // required this.postId,

  });

//بستقبل المعلومات
  factory PostModel.fromJson(Map<String, dynamic>? json) {
    // name = json['name']??'';
    // dateTime = json['dateTime']??'';
    // uId = json['uId']??'';
    // image = json['image']??'';
    // text = json['text']??'';
    // postImage = json['postImage']??'';

    // isEmailVerified = json?['isEmailVerified']??'';
    return PostModel(
      uId: json?['uId'] ?? '',
      name: json?['name'] ?? '',
      dateTime: json?['dateTime'] ?? '',
      image: json?['image'] ?? '',
      text: json?['text'] ?? '',
      postImage: json?['postImage'] ?? '',
      // // postId: json?['postId'] ?? '',

    );
  }

//بعطي المعلومات
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dateTime': dateTime,
      'uId': uId,
      'image': image,
      'text': text,
      'postImage': postImage,
      // 'postId':postId,
    };
  }
 }

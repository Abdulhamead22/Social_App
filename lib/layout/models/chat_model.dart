class ChatModel {
  final  String dateTime;
  final  String senderId;
  final  String receiverId;
  final  String text;

  ChatModel(
     {
    required this.dateTime,
    required this.senderId,
    required this.receiverId,
    required this.text,
  });

//بستقبل المعلومات
  factory ChatModel.fromJson(Map<String, dynamic>? json) {
    // dateTime = json['dateTime']??'';
    // senderId = json['senderId']??'';
    // receiverId = json['receiverId']??'';
    // text = json['text']??'';

    return ChatModel(
      dateTime: json?['dateTime'] ?? '',
      senderId: json?['senderId'] ?? '',
      receiverId: json?['receiverId'] ?? '',
      text: json?['text'] ?? '',
    );
  }

//بعطي المعلومات
  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime,
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
    };
  }
 }

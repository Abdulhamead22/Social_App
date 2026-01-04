class SocialUserModel {
  late String name;
  late String email;
  late String phone;
  late String uId;
  bool? isEmailVerified;
  SocialUserModel({
    required this.email,
    required this.name,
    required this.phone,
    required this.uId,
    this.isEmailVerified,
  });

//بستقبل المعلومات
  SocialUserModel.fromJson(Map<String, dynamic>? json) {
    email = json?['email'];
    name = json?['name'];
    phone = json?['phone'];
    uId = json?['uId'];
    isEmailVerified = json?['isEmailVerified'];
  }

//بعطي المعلومات
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'isEmailVerified':isEmailVerified,
    };
  }
}

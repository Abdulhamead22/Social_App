class SocialUserModel {
  final String name;
  final String email;
  final String phone;
  final String uId;
  final String image;
  final String cover;
  final String bio;

  bool? isEmailVerified;
  SocialUserModel({
    required this.name,
    required this.phone,
    required this.image,
    required this.cover,
    required this.bio,
    required this.email,
    required this.uId,
    this.isEmailVerified,
  });

//بستقبل المعلومات
  factory SocialUserModel.fromJson(Map<String, dynamic>? json) {
    return SocialUserModel(
      uId: json?['uId'] ?? '',
      name: json?['name'] ?? '',
      email: json?['email'] ?? '',
      phone: json?['phone'] ?? '',
      image: json?['image'] ?? '',
      cover: json?['cover'] ?? '',
      bio: json?['bio'] ?? '',
      isEmailVerified: json?['isEmailVerified'] ?? false,
    );
  }

//بعطي المعلومات
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'image': image,
      'cover': cover,
      'bio': bio,
      'isEmailVerified': isEmailVerified,
    };
  }
}

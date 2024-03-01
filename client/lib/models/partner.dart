import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class Partner {
  final String id;
  final String name;
  final String email;
  final String mobile;
  final String otp;
  final List<Map<String, String>> serviceCategory;
  final String aadharCard;
  final String address;
  final String experience;
  final String password;
  final String type;
  final String token;

  Partner({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.otp,
    required this.serviceCategory,
    required this.aadharCard,
    required this.address,
    required this.experience,
    required this.password,
    required this.type,
    required this.token,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'mobile': mobile,
      'otp': otp,
      'serviceCategory': serviceCategory,
      'aadharCard': aadharCard,
      'address': address,
      'experience': experience,
      'password': password,
      'type': type,
      'token': token,
    };
  }

  factory Partner.fromMap(Map<String, dynamic> map) {
    return Partner(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      mobile: map['mobile'] ?? '',
      otp: map['otp'] ?? '',
      aadharCard: map['aadharCard'] ?? '',
      address: map['address'] ?? '',
      experience: map['experience'] ?? '',
      password: map['password'] ?? '',
      type: map['type'] ?? '',
      token: map['token'] ?? '',
      serviceCategory: List<Map<String, String>>.from(
        (map['serviceCategory'] ?? []).map(
          (category) => Map<String, String>.from(category),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory Partner.fromJson(String source) =>
      Partner.fromMap(json.decode(source));
}

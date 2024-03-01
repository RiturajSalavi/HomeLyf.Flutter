import 'dart:convert';

class ServiceCategory {
  final String name;
  final String description;

  ServiceCategory({
    required this.name,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
    };
  }

  factory ServiceCategory.fromMap(Map<String, dynamic> map) {
    return ServiceCategory(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ServiceCategory.fromJson(String source) =>
      ServiceCategory.fromMap(json.decode(source));
}

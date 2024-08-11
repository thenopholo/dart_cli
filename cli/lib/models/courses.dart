import 'dart:convert';

class Courses {
  final int id;
  final String name;
  bool isStudent;

  Courses({
    required this.id,
    required this.name,
    required this.isStudent,
  });

  // Serialize the object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'isStudent': isStudent,
    };
  }

  String toJSON() => jsonEncode(toMap());

  // Deserialize the object
  factory Courses.fromMap(Map<String, dynamic> map) {
    return Courses(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      isStudent: map['isStudent'] ?? false,
    );
  }

  factory Courses.fromJSON(String json) => Courses.fromMap(jsonDecode(json));
}

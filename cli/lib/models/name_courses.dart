
import 'dart:convert';

class NameCourses {
  String nameCourses;
  NameCourses({
    required this.nameCourses,
  });

  Map<String, dynamic> toMap() {
    return {
      'nameCourses': nameCourses,
    };
  }

  String toJSON() => jsonEncode(toMap());

  factory NameCourses.fromMap(Map<String, dynamic> map) {
    return NameCourses(
      nameCourses: map['nameCourses'] ?? '',
    );
  }

  factory NameCourses.fromJSON(String json) => NameCourses.fromMap(jsonDecode(json));
}

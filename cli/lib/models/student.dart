import 'dart:convert';

import 'address.dart';
import 'courses.dart';
import 'name_courses.dart';

class Student {
  int id;
  String name;
  int age;
  NameCourses nameCourses;
  Courses courses;
  Address address;

  Student({
    required this.id,
    required this.name,
    required this.age,
    required this.nameCourses,
    required this.courses,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
      'nameCourses': nameCourses.toMap(),
      'courses': courses.toMap(),
      'address': address.toMap(),
    };
  }

  String toJSON() => jsonEncode(toMap());

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      age: map['age'] ?? 0,
      nameCourses: NameCourses.fromMap(map['nameCourses'] ?? {}),
      courses: Courses.fromMap(map['courses'] ?? {}),
      address: Address.fromMap(map['address'] ?? {}),
    );
  }

  factory Student.fromJSON(String json) => Student.fromMap(jsonDecode(json));
}

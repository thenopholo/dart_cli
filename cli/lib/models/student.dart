import 'dart:convert';

import 'address.dart';
import 'courses.dart';

class Student {
  final int? id;
  final String name;
  final int? age;
  final List<String> nameCourses;
  final List<Courses> courses;
  final Address address;

  Student({
    this.id,
    required this.name,
    this.age,
    required this.nameCourses,
    required this.courses,
    required this.address,
  });

  Map<String, dynamic> toMap() {
    final map = {
      'id': id,
      'name': name,
      'age': age,
      'nameCourses': nameCourses,
      'courses': courses.map((courses) => courses.toMap()).toList(),
      'address': address.toMap(),
    };

    if (age != null) {
      map['age'] = age;
    }

    return map;
  }

  String toJSON() => jsonEncode(toMap());

  factory Student.fromMap(Map<String, dynamic> map) {
    return Student(
      id: map['id'] ?? 0,
      name: map['name'] ?? '',
      age: map['age'],
      nameCourses: List<String>.from((map['nameCourses'] ?? <String>[])),
      address: Address.fromMap(map['address'] ?? {}),
      courses: map['courses']
              ?.map<Courses>((coursesMap) => Courses.fromMap(coursesMap))
              .toList() ??
          <Courses>[],
    );
  }

  factory Student.fromJSON(String json) => Student.fromMap(jsonDecode(json));
}
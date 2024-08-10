import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/student.dart';

class StudentRepository {
  Future<List<Student>> findAll() async {
    final studentsResult =
        await http.get(Uri.parse('http://localhost:8080/students'));

    if (studentsResult.statusCode != 200) {
      throw Exception('Error');
    }

    final studentsData = jsonDecode(studentsResult.body);

    return studentsData
        .map<Student>((student) => Student.fromMap(student))
        .toList();
  }

  Future<Student> findById(int id) async {
    final studentResult =
        await http.get(Uri.parse('http://localhost:8080/students/$id'));

    if (studentResult.statusCode != 200) {
      throw Exception('Error: Could not find by id');
    }

    if (studentResult.body == '{}') {
      throw Exception('Student is empty');
    }

    return Student.fromJSON(studentResult.body);
  }

  Future<void> insert(Student student) async {
    final response = await http.post(
        Uri.parse('http://localhost:8080/students'),
        body: student.toJSON(),
        headers: {
          'content-type': 'application/json',
        });

    if (response.statusCode != 200) {
      throw Exception('Error: Could not insert');
    }
  }

  Future<void> update(Student student) async {
    final response = await http.put(
        Uri.parse('http://localhost:8080/students/${student.id}'),
        body: student.toJSON(),
        headers: {
          'content-type': 'application/json',
        });

    if (response.statusCode != 200) {
      throw Exception('Error: Could not update');
    }
  }

  Future<void> deleteById(int id) async {
    final response =
        await http.delete(Uri.parse('http://localhost:8080/sutdents/$id}'));

    if (response.statusCode != 200) {
      throw Exception('Error: Could not delete');
    }
  }
}

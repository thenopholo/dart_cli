import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/courses.dart';

class ProductRepository {
  Future<Courses> findByNmae(String name) async {
    final response =
        await http.get(Uri.parse('http://localhost:8080/products?name=$name'));

    if (response.statusCode != 200) {
      throw Exception('Error');
    }

    final responseData = jsonDecode(response.body);

    if (responseData.isEmpty) {
      throw Exception('Product not found');
    }

    return Courses.fromMap(responseData.first);
  }
}

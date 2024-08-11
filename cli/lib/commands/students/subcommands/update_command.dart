import 'dart:io';
import 'package:args/command_runner.dart';

import '../../../models/address.dart';
import '../../../models/city.dart';
import '../../../models/phone.dart';
import '../../../models/student.dart';
import '../../../repositories/product_repository.dart';
import '../../../repositories/student_repository.dart';

class UpdateCommand extends Command {
  final StudentRepository studentRepository;
  final productRepository = ProductRepository();

  UpdateCommand(
    this.studentRepository,
  ) {
    argParser.addOption('file', abbr: 'f', help: 'File path');
    argParser.addOption('id', abbr: 'i', help: 'Student ID');
  }

  @override
  String get description => 'Update Student';

  @override
  String get name => 'update';

  @override
  Future<void> run() async {
    final filePath = argResults?['file'];
    final id = argResults?['id'];

    if (id == null) {
      print('Send the ID number with the --id or -i');
      return;
    }

    final students = File(filePath).readAsLinesSync();

    print('Aguarde... Atualizando dados do aluno');
    print('----------------------------------------------');

    if (students.length > 1) {
      print('Send only one student to update to the file: $filePath');
      return;
    } else if (students.isEmpty) {
      print('Send the student data to update to the file: $filePath');
      return;
    }

    var student = students.first;

    final studentData = student.split(';');
    final courseCSV = studentData[2].split(',').map((e) => e.trim()).toList();

    final courseFuture = courseCSV.map((c) async {
      final course = await productRepository.findByName(c);
      course.isStudent = true;
      return course;
    }).toList();

    final courses = await Future.wait(courseFuture);

    final studentModel = Student(
      id: int.parse(id),
      name: studentData[0],
      age: int.parse(studentData[1]),
      nameCourses: courseCSV,
      courses: courses,
      address: Address(
        street: studentData[3],
        number: int.parse(studentData[4]),
        zipCode: studentData[5],
        city: City(id: 1, name: studentData[6]),
        phone: Phone(
          ddd: int.parse(studentData[7]),
          number: studentData[8],
        ),
      ),
    );

    await studentRepository.update(studentModel);

    print('----------------------------------------------');
    print('Aluno atualizado com sucesso');
  }
}

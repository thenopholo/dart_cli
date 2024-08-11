import 'dart:io';
import 'package:args/command_runner.dart';

import '../../../models/address.dart';
import '../../../models/city.dart';
import '../../../models/phone.dart';
import '../../../models/student.dart';
import '../../../repositories/product_repository.dart';
import '../../../repositories/student_repository.dart';

class InsertCommand extends Command {
  final StudentRepository studentRepository;
  final productRepository = ProductRepository();

  InsertCommand(
    this.studentRepository,
  ) {
    argParser.addOption('file', abbr: 'f', help: 'File path');
  }

  @override
  String get description => 'Insert Student';

  @override
  String get name => 'insert';

  @override
  Future<void> run() async {
    print('Aguarde...');
    final filePath = argResults?['file'];
    final students = File(filePath).readAsLinesSync();
    print('----------------------------------------------');

    for (var student in students) {
      final studentData = student.split(';');
      final courseCSV = studentData[2].split(',').map((e) => e.trim()).toList();

      final courseFuture = courseCSV.map((c) async {
        final course = await productRepository.findByName(c);
        course.isStudent = true;
        return course;
      }).toList();

      final courses = await Future.wait(courseFuture);

      final studentModel = Student(
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
            )),
      );

      await studentRepository.insert(studentModel);
    }

    print('----------------------------------------------');
    print('Alunos inseridos com sucesso');
  }
}

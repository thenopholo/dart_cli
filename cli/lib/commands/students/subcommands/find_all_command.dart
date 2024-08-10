import 'dart:io';
import 'package:args/command_runner.dart';

import '../../../repositories/student_repository.dart';

class FindAllCommand extends Command {
  final StudentRepository studentRepository;

  FindAllCommand(
    this.studentRepository,
  );

  @override
  String get description => 'Find All Students';

  @override
  String get name => 'findAll';

  @override
  Future<void> run() async {
    print('Aguarde... Buscando alunos');
    final students = await studentRepository.findAll();
    print('Gostaria de ver os curso também? (S ou N)');

    final showCourses = stdin.readLineSync();
    print('----------------------------------------------');
    print('Alunos:');
    print('----------------------------------------------');
    for (var student in students) {
      if (showCourses?.toLowerCase() == 's') {
        print('ID: ${student.id}');
        print('Nome: ${student.name}');
        print(
            'Cursos: ${student.courses.where((courses) => courses.isStudent).map((e) => e.name).toList()}');
        print('----------------------------------------------');
      } else {
        print('ID: ${student.id}');
        print('Nome: ${student.name}');
        print('----------------------------------------------');
      }
    }
  }
}

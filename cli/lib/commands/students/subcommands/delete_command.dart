import 'dart:io';
import 'package:args/command_runner.dart';

import '../../../repositories/product_repository.dart';
import '../../../repositories/student_repository.dart';

class DeleteCommand extends Command {
  final StudentRepository studentRepository;
  final productRepository = ProductRepository();

  DeleteCommand(
    this.studentRepository,
  ) {
    argParser.addOption('id', abbr: 'i', help: 'Student ID');
  }

  @override
  String get description => 'Delete Student';

  @override
  String get name => 'delete';

  @override
  Future<void> run() async {
    final id = argResults?['id'];
    final student = await studentRepository.findById(id);

    if (id == null) {
      print('Send the ID number with the --id or -i');
      return;
    }

    print(
        'Tem certeza que deseja apagar o aluno: ${student.name} (ID: $id)? (S ou N)');
    print('----------------------------------------------');
    final confirm = stdin.readLineSync();

    if (confirm?.toLowerCase() == 's') {
      studentRepository.deleteById(id);
      print('----------------------------------------------');
      print('Aluno apagado com sucesso');
      print('----------------------------------------------');
    } else {
      print('----------------------------------------------');
      print('Operação cancelada');
      print('----------------------------------------------');
    }
  }
}

import 'package:args/command_runner.dart';

import '../../../repositories/student_repository.dart';

class FindByIdCommand extends Command {
    final StudentRepository studentRepository;

  FindByIdCommand(
    this.studentRepository,
  ){
    argParser.addOption('id', abbr: 'i', help:'Student ID');
  }

  @override
  String get description => 'Find Student by ID';

  @override
  String get name => 'byId';

  @override
  Future<void> run() async {
    if (argResults?['id'] == null) {
      print('Send the ID number with the --id or -i');
      return;
    }

    final id = int.parse(argResults?['id']);
    print('Aguarde... Buscando aluno');
    final student = await studentRepository.findById(id);
    print('----------------------------------------------');
    print('Aluno:');
    print('----------------------------------------------');
    print('Nome: ${student.name}');
    print('Idade: ${student.age ?? 'Não informado'}');
    print('Cursos:');
    student.nameCourses.forEach(print);
    print('Endereço:');
    print('${student.address.street} ${student.address.zipCode}');
  }
  

}
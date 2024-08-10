
import 'package:args/command_runner.dart';

import '../../repositories/student_repository.dart';
import 'subcommands/find_all_command.dart';
import 'subcommands/find_by_id_command.dart';

class StudentsCommands extends Command {
  @override
  String get description => 'Students Operations';

  @override
  String get name => 'students';
  
  StudentsCommands() {
    final studentRepository = StudentRepository();
    addSubcommand(FindAllCommand(studentRepository));
    addSubcommand(FindByIdCommand(studentRepository));
  }

}
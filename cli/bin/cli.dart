import 'package:args/command_runner.dart';
import 'package:cli/commands/students/students_commands.dart';

void main(List<String> arguments) {
  CommandRunner('dart_cli', 'Comando de exemplo')
    ..addCommand(StudentsCommands())
    ..run(arguments);
}
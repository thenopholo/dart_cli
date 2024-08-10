import 'package:args/args.dart';
import 'package:args/command_runner.dart';

void main(List<String> arguments) {
  CommandRunner('dart_cli', 'Comando de exemplo')
    ..addCommand(CliCommand())
    ..run(arguments);
}

class CliCommand extends Command {
  @override
  String get description => 'Exemplo de comando';

  @override
  String get name => 'dart_cli';

  CliCommand() {
    argParser.addFlag('data', abbr: 'd', help: 'Flag de exemplo');
    argParser.addOption('name', abbr: 'n', help: 'Nome de exemplo');
    argParser.addOption('template', abbr: 't', help: 'Template de exemplo');
  }

  @override
  void run() {
    print('Comando executado');
  }
}

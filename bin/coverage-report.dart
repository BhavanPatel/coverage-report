// ignore_for_file: file_names

import 'package:args/args.dart';
import 'package:coverage_report/exporter.dart';

void main(List<String> arguments) {
  const String commandGenerate = 'generate';
  const String commandClean = 'clean';

  final ArgParser parser = ArgParser();

  final fileParser = ArgParser();
  parser.addCommand(commandGenerate, fileParser);

  final cleanParser = ArgParser();
  parser.addCommand(commandClean, cleanParser);

  ArgResults results = parser.parse(arguments);

  void _noCommand() {
    print(
        'No Command Found!!\nTry using `coverage-report generate` or `coverage-report merge`');
  }

  if (results.command != null) {
    switch (results.command.name) {
      case commandGenerate:
        generate(results: results);
        break;
      case commandClean:
        clean(results: results);
        break;
      default:
        _noCommand();
    }
  } else {
    _noCommand();
  }
}

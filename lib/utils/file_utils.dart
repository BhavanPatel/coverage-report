import 'package:args/args.dart';

class FileUtils {
  static String filePath(ArgResults results) {
    const String defaultPath = 'coverage/lcov.info';
    final arguments = results.command.arguments;
    return arguments.isNotEmpty ? arguments.first : defaultPath;
  }
}

import 'dart:io';

import 'package:args/args.dart';
import 'package:coverage_report/constants/common.dart';

Future<void> clean({
  ArgResults results,
}) async {
  print('Cleaning All Files... ');
  final bool exists = await File(CommonConstants.reportPath).exists();
  if (exists) {
    await File(CommonConstants.reportPath).delete(recursive: true);
  }
  print('Clean Sucess! ');
}

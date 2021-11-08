// ignore_for_file: avoid_print

import 'dart:io';

import 'package:args/args.dart';
import 'package:coverage_report/constants/common.dart';
import 'package:coverage_report/constants/coverage_constants.dart';
import 'package:coverage_report/models/coverage.dart';
import 'package:coverage_report/models/reporter.dart';
import 'package:coverage_report/utils/file_utils.dart';

Future<List<Coverage>> readFile(String fileContent) async {
  List<Coverage> _array = [];
  fileContent.split('end_of_record').forEach(
    (file) {
      file.trim();
      if (file.length > 1 && file.isNotEmpty) {
        String fileName = '';
        double totalLine = 0;
        double coveredLine = 0;
        file.split('\n').forEach((line) {
          line.trim();
          if (line.isNotEmpty) {
            final allParts = line.split(':');
            final parts = [allParts.removeAt(0), allParts.join(':')];

            switch (parts[0].toString().toUpperCase()) {
              case 'SF':
                fileName = parts.sublist(1).join(':').trim();
                break;
              case 'LF':
                totalLine = double.parse(parts[1].trim());
                break;
              case 'LH':
                coveredLine = double.parse(parts[1].trim());
                break;
              default:
            }
          }
        });

        final Coverage item = Coverage(
          file: fileName,
          totalLine: totalLine,
          coveredLine: coveredLine,
          percentage: (coveredLine * 100 / totalLine).floorToDouble(),
        );

        _array.add(item);
      }
    },
  );
  return _array;
}

// ignore: missing_return
Future<List<Coverage>> parse(String path) async {
  final bool exists = await File(path).exists();
  if (exists) {
    final String fileString = await File(path).readAsString();
    final List<Coverage> result = await readFile(fileString);
    return result;
  }
}

Future<String> generateReporterResponse({
  String path,
  List<Coverage> content,
}) async {
  List<String> reporters = [];

  for (final Coverage item in content) {
    if (item.percentage < CoverageConstants.covergeLimit) {
      Reporter report = Reporter(
        type: CoverageConstants.type,
        checkName: CoverageConstants.checkName,
        category: CoverageConstants.category,
        description: '${CoverageConstants.description} ${item.percentage}%.',
        location: Location(lines: Lines(begin: 0, end: 0), path: item.file),
        severity: CoverageConstants.severity,
      );
      final String updatedReporter = report.toJson().toString();
      reporters.add(updatedReporter);
    }
  }
  return reporters.isNotEmpty ? reporters.toString() : null;
}

Future<void> saveResponse({
  String path,
  String content,
}) async {
  if (content.isNotEmpty) {
    final _path = CommonConstants.reportPath + CommonConstants.reportFile;
    Future<bool> _checkForExistingReport() async {
      return File(_path).exists();
    }

    bool _fileExists = await _checkForExistingReport();
    if (_fileExists) {
      final String _oldContent = await File(_path).readAsString();
      final String _existingJson =
          _oldContent.substring(1, _oldContent.length - 1);

      final String _newJson = content.substring(1, content.length - 1);
      final String _replacebleContent = '[$_existingJson,$_newJson]';

      File _file = await File(_path).create(recursive: true);
      await _file.writeAsString(_replacebleContent);

      print('Added new report and updated : ${_file.path}');
    } else {
      File _file = await File(_path).create(recursive: true);
      await _file.writeAsString(content);

      print('Created : ${_file.path}');
    }
  }
}

Future<void> generate({
  ArgResults results,
}) async {
  final targetPath = FileUtils.filePath(results);
  print('Target File : $targetPath');
  await parse(targetPath).then((res) async {
    final reporterResponse =
        await generateReporterResponse(path: targetPath, content: res);
    if (reporterResponse != null) {
      await saveResponse(
        path: targetPath,
        content: reporterResponse,
      );
    }
  });
}

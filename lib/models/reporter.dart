import 'dart:convert';

import 'package:coverage_report/enums/category.dart';
import 'package:coverage_report/enums/severity.dart';
import 'package:meta/meta.dart';

class Lines {
  int begin;
  int end;
  Lines({
    @required this.begin,
    @required this.end,
  });

  @override
  String toString() => 'Lines(begin: $begin, end: $end)';

  Map<String, dynamic> toMap() => {
        'begin': begin,
        'end': end,
      };

  String toJson() => json.encode(toMap());
}

class Location {
  String path;
  Lines lines;
  Location({
    @required this.path,
    @required this.lines,
  });

  Map<String, dynamic> toMap() => {
        'path': path,
        'lines': lines.toMap(),
      };

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'Location(path: $path, lines: $lines)';
}

class Reporter {
  String type;
  String checkName;
  Category category;
  String description;
  Location location;
  Severity severity;
  Reporter({
    @required this.type,
    @required this.checkName,
    @required this.category,
    @required this.description,
    @required this.location,
    @required this.severity,
  });

  Map<String, dynamic> toMap() => {
        'type': type,
        'checkName': checkName,
        'category': category.name,
        'description': description,
        'location': location.toMap(),
        'severity': severity.name,
      };

  String toJson() => json.encode(toMap());

  @override
  String toString() =>
      'Reporter(type: $type, checkName: $checkName, category: $category, description: $description, location: $location, severity: $severity)';
}

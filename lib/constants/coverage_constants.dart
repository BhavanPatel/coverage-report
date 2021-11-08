import 'package:coverage_report/enums/category.dart';
import 'package:coverage_report/enums/severity.dart';

class CoverageConstants {
  static String type = 'issue';
  static double covergeLimit = 90;
  static String checkName = 'Test Coverage';
  static Category category = Category.bugRisk;
  static String description =
      'Please make sure coverage is more then $covergeLimit%. Your test coverage is only  ';
  static Severity severity = Severity.major;
}

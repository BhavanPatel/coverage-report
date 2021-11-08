import 'dart:convert';

class Coverage {
  String file;
  double totalLine;
  double coveredLine;
  double percentage;

  Coverage({
    this.file,
    this.totalLine,
    this.coveredLine,
    this.percentage,
  });

  Map<String, dynamic> toMap() {
    return {
      'file': file,
      'totalLine': totalLine,
      'coveredLine': coveredLine,
      'percentage': percentage,
    };
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() {
    return 'Coverage(file: $file, totalLine: $totalLine, coveredLine: $coveredLine, percentage: $percentage)';
  }
}

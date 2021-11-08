enum Severity {
  info,
  minor,
  major,
  critical,
  blocker,
}

extension SeverityExtention on Severity {
  String get name {
    switch (this) {
      case Severity.info:
        return 'info';
      case Severity.minor:
        return 'minor';
      case Severity.major:
        return 'major';
      case Severity.critical:
        return 'critical';
      case Severity.blocker:
        return 'blocker';
      default:
        return null;
    }
  }
}

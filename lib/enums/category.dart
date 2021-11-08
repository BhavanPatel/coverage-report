enum Category {
  bugRisk,
  clarity,
  compatibility,
  complexity,
  duplication,
  performance,
  security,
  style,
}

extension CategoryExtention on Category {
  String get name {
    switch (this) {
      case Category.bugRisk:
        return 'Bug Risk';
      case Category.clarity:
        return 'Clarity';
      case Category.compatibility:
        return 'Compatibility';
      case Category.complexity:
        return 'Complexity';
      case Category.duplication:
        return 'Duplication';
      case Category.performance:
        return 'Performance';
      case Category.security:
        return 'Security';
      case Category.style:
        return 'Style';
      default:
        return null;
    }
  }
}

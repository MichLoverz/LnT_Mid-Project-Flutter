class WaterEntry {
  final DateTime date;
  double liters;

  WaterEntry({required this.date, required this.liters});

  String get category {
    if (liters < 1.5) return 'Bad';
    if (liters <= 2.0) return 'Average';
    return 'Good';
  }

  String get formattedDate {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  /// Returns true if this entry is on the same day as [other].
  bool isSameDate(DateTime other) {
    return date.year == other.year &&
        date.month == other.month &&
        date.day == other.day;
  }
}

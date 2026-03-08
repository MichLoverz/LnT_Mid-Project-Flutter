class StepEntry {
  final DateTime date;
  int steps;

  StepEntry({required this.date, required this.steps});

  String get category {
    if (steps < 4000) return 'Bad';
    if (steps <= 8000) return 'Average';
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

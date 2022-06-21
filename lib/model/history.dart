const String tableHistory = 'history';

class HistoryFields {

  static final List<String> values = [
    id, productive, unproductive, date
  ];
  static const String id = '_id';
  static const String productive = 'productive';
  static const String unproductive = 'unproductive';
  static const String date = 'date';
}

class History {
  final int? id;
  final int producitve;
  final int unproductive;
  final DateTime date;

  const History({
    this.id,
    required this.producitve,
    required this.unproductive,
    required this.date,
  });

  History copy({
    int? id,
    int? producitve,
    int? unproductive,
    DateTime? date,
  }) =>
      History(
        id: id ?? this.id,
        producitve: producitve ?? this.producitve,
        unproductive: unproductive ?? this.unproductive,
        date: date ?? this.date 
      );

  static History fromJson(Map<String, Object?> json) => History(
    id: json[HistoryFields.id] as int?,
    producitve: json[HistoryFields.productive] as int,
    unproductive: json[HistoryFields.unproductive] as int,
    date: DateTime.parse(json[HistoryFields.date] as String),
  );

  Map<String, Object?> toJson() => {
    HistoryFields.id: id,
    HistoryFields.productive: producitve,
    HistoryFields.unproductive: unproductive,
    HistoryFields.date: date.toIso8601String(),
  };
}
class Mark {
  final double score;
  final String subject;
  final DateTime date;
  final String? description;

  Mark({
    required this.score,
    required this.subject,
    required this.date,
    this.description});

  //from JSON to Mark object
  factory Mark.fromJson(Map<String, dynamic> json) =>
    Mark(
      score: json['score'] as double,
      subject: json['subject'] as String,
      date: DateTime.parse(json['date'] as String),
      description: json['description'] as String?
      );

  //from Mark object to JSON
  Map<String, dynamic> toJson() =>
   {
    'score': score,
    'subject': subject,
    'date': date.toIso8601String(),
    'description': description,
  };
  @override
  String toString() {
    return '''
Mark:
  Subject: $subject
  Score: $score
  Date: ${date.toIso8601String()}
  Description: ${description ?? "No description"}
    ''';
  }
}
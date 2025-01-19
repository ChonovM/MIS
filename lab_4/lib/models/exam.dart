class Exam {
  final String subject;
  final DateTime date;
  final String location;

  Exam({required this.subject, required this.date, required this.location});

  Map<String, dynamic> toJson() {
    return {
      'subject': subject,
      'date': date.toIso8601String(),
      'location': location,
    };
  }

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      subject: json['subject'],
      date: DateTime.parse(json['date']),
      location: json['location'],
    );
  }
}

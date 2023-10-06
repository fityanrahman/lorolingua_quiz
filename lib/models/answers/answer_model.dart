class Answers {
  final String topicName;
  final int correct;
  final int incorrect;
  final List<Detail> details;

  Answers({
    required this.topicName,
    required this.correct,
    required this.incorrect,
    required this.details,
  });

  factory Answers.fromJson(Map<String, dynamic> json) => Answers(
        topicName: json["topic_name"],
        correct: json["correct"],
        incorrect: json["incorrect"],
        details:
            List<Detail>.from(json["details"].map((x) => Detail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "topic_name": topicName,
        "correct": correct,
        "incorrect": incorrect,
        "details": List<dynamic>.from(details.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return '{correct : $correct, false : $incorrect, topicName : $topicName, details : $details}';
  }
}

class Detail {
  final String question;
  final String solution;
  final String answered;
  final bool isTrue;

  Detail({
    required this.question,
    required this.solution,
    required this.answered,
    required this.isTrue,
  });

  factory Detail.fromJson(Map<String, dynamic> json) => Detail(
        question: json["question"],
        solution: json["solution"],
        answered: json["answered"],
        isTrue: json["isTrue"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "solution": solution,
        "answered": answered,
        "isTrue": isTrue,
      };

  @override
  String toString() {
    return 'question : $question, solution : $solution, answered : $answered, isTrue :$isTrue';
  }
}

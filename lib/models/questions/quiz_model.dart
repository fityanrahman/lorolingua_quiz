class Quiz {
  final List<Topic> topics;

  Quiz({
    required this.topics,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) => Quiz(
        topics: List<Topic>.from(json["topics"].map((x) => Topic.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "topics": List<dynamic>.from(topics.map((x) => x.toJson())),
      };
}

class Topic {
  final String idTopic;
  final String topicName;
  final List<Question> questions;

  Topic({
    required this.idTopic,
    required this.topicName,
    required this.questions,
  });

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        idTopic: json["id_topic"],
        topicName: json["topic_name"],
        questions: List<Question>.from(
            json["questions"].map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_topic": idTopic,
        "topic_name": topicName,
        "questions": List<dynamic>.from(questions.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return 'topicName : $topicName';
  }
}

class Question {
  final String idQuestion;
  final String question;
  final int idSolution;
  final List<Choice> choices;

  Question({
    required this.idQuestion,
    required this.question,
    required this.idSolution,
    required this.choices,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        idQuestion: json["id_question"],
        question: json["question"],
        idSolution: json["id_solution"],
        choices:
            List<Choice>.from(json["choices"].map((x) => Choice.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id_question": idQuestion,
        "question": question,
        "id_solution": idSolution,
        "choices": List<dynamic>.from(choices.map((x) => x.toJson())),
      };
}

class Choice {
  final int idChoice;
  final String choice;

  Choice({
    required this.idChoice,
    required this.choice,
  });

  factory Choice.fromJson(Map<String, dynamic> json) => Choice(
        idChoice: json["id_choice"],
        choice: json["choice"],
      );

  Map<String, dynamic> toJson() => {
        "id_choice": idChoice,
        "choice": choice,
      };
}

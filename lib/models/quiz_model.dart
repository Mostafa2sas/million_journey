class QuizModel {
  final String question;
  final List<String> choices;
  final String correctAnswer;

  QuizModel({
    required this.choices,
    required this.question,
    required this.correctAnswer,
  });

  factory QuizModel.fromJson(json) {
    var choices = List<String>.from(json['incorrect_answers']);
    choices.add(json['correct_answer']);
    choices.shuffle();

    return QuizModel(
      choices: choices,
      question: json['question'],
      correctAnswer: json['correct_answer'],
    );
  }
}

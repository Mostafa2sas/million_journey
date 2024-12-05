abstract class QuizState {}

class QuizInitial extends QuizState {}

class QuizLoadingState extends QuizState {}

class QuizLoadedState extends QuizState {}

class CorrectAnswerState extends QuizState {}

class AnswerColorState extends QuizState {}

class QuizErrorState extends QuizState {
  final String errMessage;

  QuizErrorState(this.errMessage);
}

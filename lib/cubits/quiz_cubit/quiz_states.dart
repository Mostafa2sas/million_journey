import 'package:million_journey/models/quiz_model.dart';

abstract class QuizState {}

class QuizInitial extends QuizState {}

class QuizLoadingState extends QuizState {}

class QuizLoadedState extends QuizState {
  List<QuizModel> questions;

  QuizLoadedState(this.questions);
}

class QuizErrorState extends QuizState {
  final String errMessage;

  QuizErrorState(this.errMessage);
}

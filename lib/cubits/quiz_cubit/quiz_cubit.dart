import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:million_journey/cubits/quiz_cubit/quiz_states.dart';
import 'package:million_journey/models/quiz_model.dart';
import 'package:million_journey/services/quiz_services.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit() : super(QuizInitial());
  QuizServices quizServices = QuizServices();
  int currentIndexOfQuestion = 0;
  int correctAnswer = 0;
  int indexOfScore = 0;
  List<QuizModel> questions = [];

  List<Color> optionColor = [
    Colors.blue,
    Colors.blue,
    Colors.blue,
    Colors.blue,
  ];
  List<int> score = [
    0,
    1000,
    5000,
    10000,
    25000,
    50000,
    75000,
    125000,
    250000,
    500000,
    1000000,
  ];

  resetColor() {
    optionColor = [
      Colors.blue,
      Colors.blue,
      Colors.blue,
      Colors.blue,
    ];
  }

  changeColor(index) {
    if (questions[currentIndexOfQuestion].correctAnswer ==
        questions[currentIndexOfQuestion].choices[index]) {
      optionColor[index] = Colors.green;
    } else {
      optionColor[index] = Colors.red;
    }
    emit(AnswerColorState());
  }

  goToNextQuestion() {
    currentIndexOfQuestion++;
    resetColor();
    emit(CorrectAnswerState());
  }

  getQuestions() async {
    emit(QuizLoadingState());
    try {
      questions = await quizServices.getQuizData();
      emit(QuizLoadedState());
    } catch (e) {
      emit(QuizErrorState(e.toString()));
    }
  }
}

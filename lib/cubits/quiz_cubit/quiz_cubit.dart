import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:million_journey/cubits/quiz_cubit/quiz_states.dart';
import 'package:million_journey/models/quiz_model.dart';
import 'package:million_journey/services/quiz_services.dart';

class QuizCubit extends Cubit<QuizState> {
  QuizCubit(this.quizServices) : super(QuizInitial());
  QuizServices quizServices;

  getQuestions() async {
    emit(QuizLoadingState());
    try {
      List<QuizModel> quizModel = await quizServices.getQuizData();
      emit(QuizLoadedState(quizModel));
    } catch (e) {
      emit(QuizErrorState(e.toString()));
    }
  }
}

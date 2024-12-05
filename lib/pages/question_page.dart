import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:million_journey/cubits/quiz_cubit/quiz_cubit.dart';
import 'package:million_journey/cubits/quiz_cubit/quiz_states.dart';
import 'package:million_journey/models/quiz_model.dart';
import 'package:million_journey/pages/result_page.dart';
import 'package:million_journey/widgets/custom_button.dart';

class QuestionPage extends StatelessWidget {
  const QuestionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizCubit()..getQuestions(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: Colors.white,
        ),
        body: BlocBuilder<QuizCubit, QuizState>(
          builder: (context, state) {
            final cubit = context.read<QuizCubit>();
            if (state is QuizLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is QuizErrorState) {
              return Center(
                child: Text(state.errMessage),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 32,
                horizontal: 32,
              ),
              child: Column(
                children: [
                  Text(
                    'Score : ${cubit.score[cubit.indexOfScore]}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    text:
                        cubit.questions[cubit.currentIndexOfQuestion].question,
                    height: 150,
                    width: double.infinity,
                    color: Colors.blue,
                  ),
                  const SizedBox(height: 32),
                  Expanded(
                    child: GridView.builder(
                        itemCount: 4,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 32,
                          mainAxisSpacing: 40,
                          childAspectRatio: 1.4,
                        ),
                        itemBuilder: (context, index) {
                          QuizModel question =
                              cubit.questions[cubit.currentIndexOfQuestion];
                          return CustomButton(
                            color: cubit.optionColor[index],
                            height: 150,
                            width: 460,
                            text: question.choices[index],
                            onTap: () {
                              if (question.correctAnswer ==
                                  question.choices[index]) {
                                cubit.changeColor(index);
                                cubit.correctAnswer++;
                                cubit.indexOfScore++;
                                if (cubit.currentIndexOfQuestion <
                                    cubit.questions.length - 1) {
                                  Future.delayed(const Duration(seconds: 1),
                                      () {
                                    cubit.goToNextQuestion();
                                  });
                                } else {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ResultPage(
                                      correctAnswer: cubit.correctAnswer,
                                    );
                                  }));
                                }
                              } else {
                                cubit.changeColor(index);
                                Future.delayed(const Duration(seconds: 1), () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) {
                                      return ResultPage(
                                        correctAnswer: cubit.correctAnswer,
                                      );
                                    }),
                                  );
                                });
                              }
                            },
                          );
                        }),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

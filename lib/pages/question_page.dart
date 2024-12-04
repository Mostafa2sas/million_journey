import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:million_journey/cubits/quiz_cubit/quiz_cubit.dart';
import 'package:million_journey/cubits/quiz_cubit/quiz_states.dart';
import 'package:million_journey/models/quiz_model.dart';
import 'package:million_journey/pages/result_page.dart';
import 'package:million_journey/widgets/custom_button.dart';

class QuestionPage extends StatefulWidget {
  const QuestionPage({super.key});

  @override
  State<QuestionPage> createState() => _QuestionPageState();
}

class _QuestionPageState extends State<QuestionPage> {
  QuizModel? quizModel;
  int currentIndexOfQuestion = 0;
  int correctAnswer = 0;
  int indexOfScore = 0;

  var optionColor = [
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

  goToNextQuestion() {
    setState(() {
      currentIndexOfQuestion++;
      resetColor();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      body: BlocBuilder<QuizCubit, QuizState>(
        builder: (context, state) {
          if (state is QuizLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is QuizLoadedState) {
            return Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 32,
                horizontal: 32,
              ),
              child: Column(
                children: [
                  Text(
                    'Score : ${score[indexOfScore]}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: 30),
                  CustomButton(
                    text: state.questions[currentIndexOfQuestion].question,
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
                              state.questions[currentIndexOfQuestion];
                          return CustomButton(
                            color: optionColor[index],
                            height: 150,
                            width: 460,
                            text: question.choices[index],
                            onTap: () {
                              setState(() {
                                if (question.correctAnswer ==
                                    question.choices[index]) {
                                  optionColor[index] = Colors.green;
                                  correctAnswer++;
                                  indexOfScore++;
                                  if (currentIndexOfQuestion <
                                      state.questions.length - 1) {
                                    Future.delayed(const Duration(seconds: 1),
                                        () {
                                      goToNextQuestion();
                                    });
                                  } else {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return ResultPage(
                                        correctAnswer: correctAnswer,
                                      );
                                    }));
                                  }
                                } else {
                                  optionColor[index] = Colors.red;
                                  Future.delayed(const Duration(seconds: 1),
                                      () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) {
                                        return ResultPage(
                                          correctAnswer: correctAnswer,
                                        );
                                      }),
                                    );
                                  });
                                }
                              });
                            },
                          );
                        }),
                  ),
                ],
              ),
            );
          } else if (state is QuizErrorState) {
            return Center(
              child: Text(state.errMessage),
            );
          }
          return Container();
        },
      ),
    );
  }
}

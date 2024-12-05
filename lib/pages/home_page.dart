import 'package:flutter/material.dart';
import 'package:million_journey/pages/question_page.dart';
import 'package:million_journey/widgets/custom_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Builder(builder: (context) {
          return CustomButton(
            color: Colors.blue[900],
            height: 100,
            width: 200,
            text: 'Start',
            onTap: () {
              /* BlocProvider.of<QuizCubit>(context).getQuestions(); */
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const QuestionPage();
                  },
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

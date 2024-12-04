import 'package:flutter/material.dart';
import 'package:million_journey/pages/home_page.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key, required this.correctAnswer});
  final int correctAnswer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                correctAnswer == 10
                    ? 'Congratulation you have won the Million'
                    : 'You have lost , Try again',
                style: const TextStyle(fontSize: 24, color: Colors.white),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                style: const ButtonStyle(
                  fixedSize: WidgetStatePropertyAll(
                    Size(200, 50),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const HomePage();
                  }));
                },
                child: Text(
                  'Try again',
                  style: TextStyle(
                    color: Colors.blue[900],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

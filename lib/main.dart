import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:million_journey/cubits/quiz_cubit/quiz_cubit.dart';
import 'package:million_journey/pages/home_page.dart';
import 'package:million_journey/services/quiz_services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizCubit(QuizServices()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(scaffoldBackgroundColor: Colors.blue[900]),
        home: const HomePage(),
      ),
    );
  }
}

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:million_journey/models/quiz_model.dart';

class QuizServices {
  String apiUrl = 'https://opentdb.com/api.php?amount=10&type=multiple';

  Future<List<QuizModel>> getQuizData() async {
    http.Response response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      List<QuizModel> questions = (data['results'] as List)
          .map((item) => QuizModel.fromJson(item))
          .toList();
      return questions;
    } else {
      throw Exception('Failed to load questions');
    }
  }
}

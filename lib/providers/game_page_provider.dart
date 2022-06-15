import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio dio = Dio();
  final int maxQuestions = 10;

  List? questions;
  int currentQuestionCount = 0;
  BuildContext context;
  GamePageProvider({required this.context}) {
    dio.options.baseUrl = 'https://opentdb.com/api.php';
    _getQuestionsFromApi();
  }
  Future<void> _getQuestionsFromApi() async {
    var _response = await dio.get(
      '',
      queryParameters: {
        'amount': 10,
        'type': 'boolean',
        'difficulty': 'easy',
      },
    );
    var data = jsonDecode(
      _response.toString(),
    );
    questions = data['results'];
    notifyListeners();
  }

  String getCurrenQuestionText(){
    return questions![currentQuestionCount]['question'];
  }

  void answerQuestion(String _answer) async {
    bool isCorrect = questions![currentQuestionCount]['correct_answer'] == _answer;
    currentQuestionCount++;
    print(isCorrect ? 'Correct' : 'Incorrect');
    notifyListeners();
  }
}

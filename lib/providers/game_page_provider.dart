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

  String getCurrenQuestionText() {
    return questions![currentQuestionCount]['question'];
  }

  void answerQuestion(String _answer) async {
    bool isCorrect =
        questions![currentQuestionCount]['correct_answer'] == _answer;
    currentQuestionCount++;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: isCorrect ? Colors.green : Colors.red,
          title: Text(isCorrect ? 'Right' : 'Wrong'),
          // Icon(
          //   isCorrect ? Icons.circle : Icons.cancel_sharp,
          //   color: Colors.white,
          // ),
        );
      },
    );
    await Future.delayed(
      const Duration(seconds: 1),
    );
    Navigator.pop(context);
    if (currentQuestionCount == maxQuestions){
      endGame();
    }else{
      notifyListeners();
    }

  }

  Future<void> endGame() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          backgroundColor: Colors.blue,
          title: Text(
            'Game Ended!',
            style: TextStyle(color: Colors.white, fontSize: 25),
          ),
          content: Text('Score: 0/0'),
        );

      },
    );
    await Future.delayed(
      const Duration(seconds: 2),
    );
    Navigator.pop(context);
    Navigator.pop(context);
  }
}

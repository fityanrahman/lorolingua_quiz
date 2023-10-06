import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quiz_app/models/answers/answer_model.dart';
import 'package:quiz_app/models/questions/quiz_model.dart';
import 'package:quiz_app/utils/const.dart';

class QuizProvider extends ChangeNotifier {
  String _quizName = "";

  String get quizName => _quizName;

  set quizName(String quizName) {
    _quizName = quizName;
    notifyListeners();
  }

  int _totalQuiz = 0;

  int get totalQuiz => _totalQuiz;

  set totalQuiz(int totalQuiz) {
    _totalQuiz = totalQuiz;
    notifyListeners();
  }

  int _countQuiz = 0;

  int get countQuiz => _countQuiz;

  set countQuiz(int countQuiz) {
    _countQuiz = countQuiz;
    notifyListeners();
  }

  int _correctAnswer = 0;

  int get correctAnswer => _correctAnswer;

  set correctAnswer(int correctAnswer) {
    _correctAnswer = correctAnswer;
    notifyListeners();
  }

  int _falseAnswer = 0;

  int get falseAnswer => _falseAnswer;

  set falseAnswer(int falseAnswer) {
    _falseAnswer = falseAnswer;
    notifyListeners();
  }

  List<Topic> _topic = [];

  List<Topic> get topic => _topic;

  ResultState _state = ResultState.loading;

  ResultState get state => _state;

  final List<Detail> _listDetail = [];
  List<Detail> get listDetail => _listDetail;

  // late Timer _timer;
  // Timer get timer => _timer;
  // late Timer _timer;
  double _timerValue = 1;
  double get timerValue => _timerValue;

  int _timerCount = 30;
  int get timerCount => _timerCount;
  set timerCount(int timer) {
    _timerCount = timer;
    notifyListeners();
  }

  void resetTimer() {
    _timerCount = 30;
    _timerValue = 1;
    notifyListeners();
  }

  updateRemainingTime() {
    _timerCount--;
    _timerValue = timerCount / 30;
    print('timeout : $_timerCount');
    print('timerValue : $_timerValue');
    notifyListeners();
  }
  // void startTimer() {
  //   const oneSec = Duration(seconds: 1);
  //   _timer = Timer.periodic(
  //     oneSec,
  //     (Timer timer) {
  //       if (_timerCount == 0) {
  //         timer.cancel();
  //         notifyListeners();
  //       } else {
  //         _timerCount--;
  //         _timerValue = 30000 / _timerCount;
  //         notifyListeners();
  //       }
  //     },
  //   );
  //   print(_timerCount);
  // }

  // @override
  // void dispose() {
  //   super.dispose();
  //   _timer.cancel();
  // }

  Future fetchAllTopics() async {
    _state = ResultState.loading;
    final json = await rootBundle.loadString('assets/quiz.json');

    _state = ResultState.hasData;
    Quiz quiz = Quiz.fromJson(jsonDecode(json));
    _topic = quiz.topics;
    notifyListeners();
  }

  void initQuiz(Topic topic) {
    _totalQuiz = topic.questions.length;
    _quizName = topic.topicName;
    _listDetail.clear();
    notifyListeners();
  }

  void resetQuiz() {
    _totalQuiz = 0;
    _falseAnswer = 0;
    _countQuiz = 0;
    _correctAnswer = 0;
    notifyListeners();
  }

  void addCount() {
    _countQuiz++;
    notifyListeners();
  }

  void submitAnswer({
    required int answered,
    required int index,
    required int indexTopic,
  }) {
    String question = _topic[indexTopic].questions[index].question;
    String stringSolution = (_topic[indexTopic]
        .questions[index]
        .choices
        .firstWhere(
            (e) => e.idChoice == _topic[indexTopic].questions[index].idSolution)
        .choice);
    String answers = answered == 99
        ? 'No Answer'
        : (_topic[indexTopic]
            .questions[index]
            .choices
            .firstWhere((e) => e.idChoice == answered)).choice;
    bool isTrue = _topic[indexTopic].questions[index].idSolution == answered;

    _listDetail.add(
      Detail(
        question: question,
        solution: stringSolution,
        answered: answers,
        isTrue: isTrue,
      ),
    );

    if (isTrue) {
      _correctAnswer++;
    } else {
      _falseAnswer++;
    }

    Answers answer = Answers(
        topicName: _quizName,
        correct: _correctAnswer,
        incorrect: _falseAnswer,
        details: _listDetail);

    notifyListeners();

    print(answer);
    print('length detail : ${_listDetail.length}');
  }
}

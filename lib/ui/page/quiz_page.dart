import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/questions/quiz_model.dart';
import 'package:quiz_app/provider/quiz_provider.dart';
import 'package:quiz_app/ui/page/result_page.dart';

class QuizPage extends StatefulWidget {
  final int idxTopics;
  final Topic topics;
  const QuizPage({super.key, required this.topics, required this.idxTopics});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late Timer timer;
  late Function() nextQuestion;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<QuizProvider>(context, listen: false);
      if (provider.countQuiz == 0) {
        provider.initQuiz(widget.topics);
      }
      provider.resetTimer();
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (provider.timerCount == 0) {
          timer.cancel();
          nextQuestions(provider, 99);
        } else {
          provider.updateRemainingTime();
        }
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<QuizProvider>(builder: (context, provider, _) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text('${widget.topics.topicName} Quiz'),
          actions: [TextButton(onPressed: () {}, child: const Text('Exit'))],
        ),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: provider.timerValue,
              color: Colors.orange,
            ),
            const SizedBox(height: 16),
            Text('Question ${provider.countQuiz + 1} of ${provider.totalQuiz}'),
            const SizedBox(height: 8),
            Container(
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(8)),
                  color: Theme.of(context).colorScheme.secondary),
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  Text(
                    widget.topics.questions[provider.countQuiz].question,
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.onSecondary),
                  )
                ],
              ),
            ),
            const SizedBox(height: 20),
            ListView.builder(
                shrinkWrap: true,
                itemCount:
                    widget.topics.questions[provider.countQuiz].choices.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical: 4,
                    ),
                    child: ElevatedButton(
                      onPressed: () {
                        nextQuestions(provider, index);
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize:
                            Size(MediaQuery.of(context).size.width - 32, 0),
                      ),
                      child: Text(widget.topics.questions[provider.countQuiz]
                          .choices[index].choice),
                    ),
                  );
                }),
          ],
        ),
      );
    });
  }

  nextQuestions(QuizProvider provider, int index) {
    provider.submitAnswer(
        indexTopic: widget.idxTopics,
        answered: index == 99
            ? index
            : widget
                .topics.questions[provider.countQuiz].choices[index].idChoice,
        index: provider.countQuiz);
    if (provider.countQuiz + 1 == provider.totalQuiz) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ResultPage()),
      );
    } else {
      provider.addCount();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => QuizPage(
            topics: widget.topics,
            idxTopics: widget.idxTopics,
          ),
        ),
      );
    }
  }
}

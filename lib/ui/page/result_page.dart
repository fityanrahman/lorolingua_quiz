import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/provider/quiz_provider.dart';
import 'package:quiz_app/ui/widget/answer_widget.dart';
import 'package:share_plus/share_plus.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Score'),
      ),
      body: Consumer<QuizProvider>(builder: (context, provider, _) {
        double valueCorrect = provider.correctAnswer / provider.totalQuiz;
        return SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 16,
              ),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: 150,
                      width: 150,
                      child: CircularProgressIndicator(
                        value: valueCorrect,
                        color: Colors.green,
                        backgroundColor: Colors.red,
                        strokeWidth: 8,
                      ),
                    ),
                    Text('${provider.correctAnswer} / ${provider.totalQuiz}')
                  ],
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              ElevatedButton(
                onPressed: () async {
                  await Share.share(
                      'I got ${provider.correctAnswer} / ${provider.totalQuiz} score for ${provider.quizName} Quiz on Lorolingua Quiz App!');
                },
                child: const Text('Share your score'),
              ),
              const SizedBox(height: 12),
              const Text('Your Report'),
              const SizedBox(height: 16),
              ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: provider.listDetail.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(provider.listDetail[index].question),
                      subtitle: Row(
                        children: [
                          !provider.listDetail[index].isTrue
                              ? Answer(
                                  answer: provider.listDetail[index].answered,
                                  isCorrect: false,
                                )
                              : const SizedBox(),
                          const SizedBox(width: 8),
                          Answer(
                            answer: provider.listDetail[index].solution,
                            isCorrect: true,
                          ),
                        ],
                      ),
                    );
                  })
            ],
          ),
        );
      }),
    );
  }
}

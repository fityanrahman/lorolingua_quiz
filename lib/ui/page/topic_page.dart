import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/models/questions/quiz_model.dart';
import 'package:quiz_app/provider/quiz_provider.dart';
import 'package:quiz_app/ui/page/quiz_page.dart';

class TopicPage extends StatelessWidget {
  final List<Topic> topics;

  const TopicPage({super.key, required this.topics});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Topics'),
      ),
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: topics.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => QuizPage(
                            topics: topics[index],
                            idxTopics: index,
                          )));
              Provider.of<QuizProvider>(context, listen: false).resetQuiz();
            },
            child: ListTile(
              title: Text(topics[index].topicName),
              trailing: Icon(Icons.adaptive.arrow_forward),
            ),
          );
        },
      ),
    );
  }
}

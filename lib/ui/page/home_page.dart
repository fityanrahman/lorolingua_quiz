import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/provider/quiz_provider.dart';
import 'package:quiz_app/ui/page/quiz_page.dart';
import 'package:quiz_app/ui/page/topic_page.dart';
import 'package:quiz_app/utils/const.dart';
import 'package:share_plus/share_plus.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Provider.of<QuizProvider>(context, listen: false).fetchAllTopics();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<QuizProvider>(
          builder: (context, provider, _) {
            if (provider.state == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 36, horizontal: 64),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.lightbulb,
                      size: 80,
                      color: Colors.amber,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'Lorolingua Quiz App',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 20),
                    const Text('Learn • Take Quiz • Repeat'),
                    const SizedBox(height: 50),
                    ElevatedButton(
                        onPressed: () {
                          var intValue = Random().nextInt(2);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => QuizPage(
                                        topics: provider.topic[intValue],
                                        idxTopics: intValue,
                                      )));
                          Provider.of<QuizProvider>(context, listen: false)
                              .resetQuiz();
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(MediaQuery.of(context).size.width, 0),
                        ),
                        child: const Text('Play')),
                    const SizedBox(height: 8),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TopicPage(topics: provider.topic)));
                        },
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(MediaQuery.of(context).size.width, 0),
                        ),
                        child: const Text('Topics')),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () async {
                            await Share.share(
                                "Check this cool App : Lorolingua Quiz App");
                          },
                          child: Row(children: [
                            Icon(Icons.adaptive.share),
                            const SizedBox(width: 8),
                            const Text('Share')
                          ]),
                        ),
                      ],
                    )
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

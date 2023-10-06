import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/provider/quiz_provider.dart';
import 'package:quiz_app/ui/page/topic_page.dart';
import 'package:quiz_app/utils/const.dart';

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
                      size: 64,
                    ),
                    const SizedBox(height: 40),
                    const Text('Lorolingua Quiz App'),
                    const SizedBox(height: 20),
                    const Text('Learn • Take Quiz • Repeat'),
                    const SizedBox(height: 50),
                    ElevatedButton(
                        onPressed: () {},
                        child: const Text('Play'),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(MediaQuery.of(context).size.width, 0),
                        )),
                    const SizedBox(height: 8),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      TopicPage(topics: provider.topic)));
                        },
                        child: const Text('Topics'),
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(MediaQuery.of(context).size.width, 0),
                        )),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Row(children: [
                            Icon(Icons.adaptive.share),
                            const SizedBox(width: 8),
                            const Text('Share')
                          ]),
                        ),
                        const SizedBox(width: 16),
                        TextButton(
                          onPressed: () {},
                          child: const Row(children: [
                            Icon(Icons.star),
                            SizedBox(width: 8),
                            Text('Rate Us')
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

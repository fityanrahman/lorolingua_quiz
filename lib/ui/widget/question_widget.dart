import 'package:flutter/material.dart';
import 'package:quiz_app/ui/page/result_page.dart';

class Question extends StatelessWidget {
  const Question({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                'Which is the fastest animal on the land?',
                style:
                    TextStyle(color: Theme.of(context).colorScheme.onSecondary),
              )
            ],
          ),
        ),
        const SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const ResultPage()));
          },
          child: const Text('Lion'),
          style: ElevatedButton.styleFrom(
            fixedSize: Size(MediaQuery.of(context).size.width - 32, 0),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Tiger'),
          style: ElevatedButton.styleFrom(
            fixedSize: Size(MediaQuery.of(context).size.width - 32, 0),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Cheetah'),
          style: ElevatedButton.styleFrom(
            fixedSize: Size(MediaQuery.of(context).size.width - 32, 0),
          ),
        ),
        ElevatedButton(
          onPressed: () {},
          child: const Text('Wolf'),
          style: ElevatedButton.styleFrom(
            fixedSize: Size(MediaQuery.of(context).size.width - 32, 0),
          ),
        )
      ],
    );
  }
}

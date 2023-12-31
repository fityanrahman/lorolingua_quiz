import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quiz_app/provider/quiz_provider.dart';
import 'package:quiz_app/provider/result_provider.dart';
import 'package:quiz_app/ui/page/home_page.dart';
import 'package:quiz_app/utils/style.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<QuizProvider>(
            create: (context) => QuizProvider()),
        ChangeNotifierProvider<ResultProvider>(
            create: (context) => ResultProvider()),
      ],
      child: MaterialApp(
        title: 'Lorolingua Quiz App',
        debugShowCheckedModeBanner: false,
        themeMode: themeMode,
        theme: lightTheme,
        darkTheme: darkTheme,
        home: const HomePage(),
      ),
    );
  }
}

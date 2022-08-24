import 'package:flutter/material.dart';
import 'quizBrain.dart';
import 'question.dart';

void main() {
  runApp(const MyApp());
}

QuizBrain questionObj = QuizBrain();

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          backgroundColor: Colors.grey.shade900,
          body: const SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: QuizApp(),
            ),
          )),
    );
  }
}

class QuizApp extends StatefulWidget {
  const QuizApp({Key? key}) : super(key: key);

  @override
  State<QuizApp> createState() => _QuizAppState();
}

class _QuizAppState extends State<QuizApp> {
  List<Icon> scorekeeper = [];

  void checkAnswer(bool userPickedAnswer) {
    bool correctAnswer = questionObj.getCorrectAnswer();

    setState(() {
      if (userPickedAnswer == correctAnswer) {
        scorekeeper.add(const Icon(
          Icons.check,
          color: Colors.green,
        ));
      } else {
        scorekeeper.add(const Icon(
          Icons.close,
          color: Colors.red,
        ));
      }
      bool finished = questionObj.isFinished();
      if (finished == true) {
        scorekeeper = [];
      }
      questionObj.nextQuestion();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Center(
            child: Text(
              textAlign: TextAlign.center,
              questionObj.getQuestionText(),
              style: const TextStyle(
                color: Colors.white,
                fontSize: 25.0,
              ),
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              checkAnswer(true);
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 25.0, horizontal: 160.0),
              color: Colors.green,
              child: const Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: TextButton(
            onPressed: () {
              checkAnswer(false);
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(vertical: 25.0, horizontal: 155.0),
              color: Colors.red,
              child: const Text(
                'False',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: scorekeeper,
        ),
      ],
    );
  }
}

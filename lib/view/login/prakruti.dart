import 'package:fitness/common/colo_extension.dart';
import 'package:fitness/common_widget/round_button.dart';
import 'package:fitness/view/login/what_your_goal_view.dart';
import 'package:flutter/material.dart';

class prakruti extends StatefulWidget {
  @override
  _prakrutiState createState() => _prakrutiState();
}

class _prakrutiState extends State<prakruti> {
  int _questionIndex = 0;
  int _totalScore = 0;

  final List<Map<String, Object>> _questions = [
    {
      'questionText': 'What is your Body structure?',
      'answers': [
        {'text': 'Thin', 'score': 4},
        {'text': 'Medium', 'score': 3},
        {'text': 'Fat', 'score': 2},
      ],
    },
    {
      'questionText': 'What is your Hair type?',
      'answers': [
        {'text': 'Medium', 'score': 4},
        {'text': 'Thin', 'score': 3},
        {'text': 'Thick', 'score': 2},
      ],
    },
    {
      'questionText': 'Is your digestive tract healthy?',
      'answers': [
        {'text': 'Poor', 'score': 4},
        {'text': 'Excelent', 'score': 3},
        {'text': 'Medium', 'score': 2},
      ],
    },
    {
      'questionText': 'What is you skin type?',
      'answers': [
        {'text': 'Dry', 'score': 4},
        {'text': 'Soft', 'score': 3},
        {'text': 'Radiant', 'score': 2},
      ],
    },
    {
      'questionText': 'Do you feel fatigue frequently?',
      'answers': [
        {'text': 'Little', 'score': 4},
        {'text': 'More', 'score': 3},
        {'text': 'Highest', 'score': 2},
      ],
    },
    {
      'questionText': 'What is your average Body temperature?',
      'answers': [
        {'text': 'Cold', 'score': 4},
        {'text': 'Normal', 'score': 3},
        {'text': 'Heigh', 'score': 2},
      ],
    },
    {
      'questionText': 'What is the quality of your sleep?',
      'answers': [
        {'text': 'Light', 'score': 4},
        {'text': 'Good', 'score': 3},
        {'text': 'Deep', 'score': 2},
      ],
    },
    // Add more questions here
  ];

  void _answerQuestion(int score) {
    _totalScore += score;

    setState(() {
      _questionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.white,
      body: _questionIndex < _questions.length
          ? Quiz(
              questionIndex: _questionIndex,
              questions: _questions,
              answerQuestion: _answerQuestion,
            )
          : Result(_totalScore, _resetQuiz),
    );
  }
}

class Quiz extends StatelessWidget {
  final int questionIndex;
  final List<Map<String, Object>> questions;
  final Function(int) answerQuestion;

  Quiz({
    required this.questionIndex,
    required this.questions,
    required this.answerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Image.asset(
              "assets/img/med-1.jpg",
              width: 360,
              alignment: Alignment.center,
              fit: BoxFit.fitWidth,
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              questions[questionIndex]['questionText'] as String,
              style: TextStyle(
                  color: TColor.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 50,
            ),
            ...(questions[questionIndex]['answers']
                    as List<Map<String, Object>>)
                .map((answer) {
              // return
              return RoundButton(
                title: answer['text'] as String,
                onPressed: () => answerQuestion(answer['score'] as int),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

class Result extends StatelessWidget {
  final int totalScore;
  final Function resetQuiz;

  Result(this.totalScore, this.resetQuiz);

  @override
  Widget build(BuildContext context) {
    String resultText = 'Your Prakruti is:';

    if (totalScore <= 14) {
      resultText += ' Khapha';
    } else if (totalScore <= 21) {
      resultText += ' Pitta';
    } else {
      resultText += ' Vaata';
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          resultText,
          style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        SizedBox(
          height: 50,
        ),
        RoundButton(
            title: "Next >",
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const WhatYourGoalView()));
            }),
      ],
    );
  }
}

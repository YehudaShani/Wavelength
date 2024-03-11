import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wavelength/widgets/question.dart';
import 'package:wavelength/questions.dart';

Map<String, dynamic> questionsData = wavelengthData;

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var guess = 0;
  var target = 0;
  var score = 0;
  TextEditingController guessController = TextEditingController();

  void updateGuess(int newGuess) {
    setState(() {
      guess = newGuess;
    });
  }

  void updateTarget(int newTarget) {
    setState(() {
      target = newTarget;
    });
  }

  void checkGuess() {
    if (guess == target) {
      setState(() {
        score += 1;
      });
    }
    updateTarget(Random().nextInt(10) + 1);
    guessController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wavelength'),
      ),
      body: Column(
        children: [
          SizedBox(height: 60),
          QuestionWidget(category: "Pets", subCategory: "Cuteness"),
          Text('The target is $target'),
          Text('Your score is $score'),
          TextField(
            controller: guessController,
            onChanged: (value) {
              updateGuess(int.parse(value));
            },
          ),
          ElevatedButton(onPressed: checkGuess, child: Text('Check Guess')),
        ],
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wavelength/widgets/question.dart';
import 'package:wavelength/questions.dart';
import 'package:wavelength/widgets/target_guess.dart';

Map<String, dynamic> questionsData = wavelengthData;

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var guess = 0;
  var target = 0;

  @override
  void initState() {
    super.initState();
    target = Random().nextInt(10) + 1;
  }

  void updateGuess(int newGuess) {
    setState(() {
      guess = newGuess;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60),
          QuestionWidget(category: "Pets", subCategory: "Cuteness"),
          Text('The guess is: $guess'),
          Text('submit button'),
        ],
      ),
    );
  }
}

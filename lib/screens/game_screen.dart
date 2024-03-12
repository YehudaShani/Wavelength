import 'dart:math';

import 'package:flutter/material.dart';
import 'package:wavelength/widgets/question.dart';
import 'package:wavelength/questions.dart';
import 'package:wavelength/widgets/radial_slider.dart';
import 'package:wavelength/utils/question_utils.dart';

List<List<String>> questionsData = makeQuestionList(wavelengthData);

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var guess = 0;
  var target = 0;
  var score = 0;
  bool isGuessing = false;
  List<List<String>> questionsData = [];

  @override
  void initState() {
    super.initState();
    updateTarget(Random().nextInt(10) + 1);
    questionsData = makeQuestionList(wavelengthData);
    questionsData.shuffle();
    print(questionsData);
  }

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
    changePlayer();
  }

  void changePlayer() {
    setState(() {
      isGuessing = !isGuessing;
    });
  }

  @override
  Widget build(BuildContext context) {
    String topic = getQuestionTopic(questionsData[0]);
    String scale = getQuestionScale(questionsData[0]);
    String bottomLabel = getQuestionBottomLabel(questionsData[0]);
    String topLabel = getQuestionTopLabel(questionsData[0]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Wavelength'),
      ),
      body: Column(
        children: [
          Text(
            'Your score is $score',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.left,
          ),
          QuestionWidget(category: topic, subCategory: scale),
          Text('The target is $target'),
          Text('your guess is $guess'),
          isGuessing
              ? Column(children: [
                  RadialSlider(
                      onChange: updateGuess,
                      bottomLabel: bottomLabel,
                      topLabel: topLabel),
                  ElevatedButton(
                      onPressed: checkGuess, child: const Text('Submit')),
                ])
              : IconButton(
                  onPressed: changePlayer, icon: const Icon(Icons.check)),
        ],
      ),
    );
  }
}

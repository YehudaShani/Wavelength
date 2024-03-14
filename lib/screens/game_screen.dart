import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:wavelength/widgets/question.dart';
import 'package:wavelength/questions.dart';
import 'package:wavelength/widgets/radial_slider.dart';
import 'package:wavelength/utils/question_utils.dart';
import 'package:wavelength/utils/firebase_utils.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key, required this.gameId, required this.playerName});
  final String gameId;
  final String playerName;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var guess = 0;
  var target = 0;
  var score = 0;
  var round = 0;
  bool isGuessing = false;
  List<String> questionData = [];
  final databaseReference = FirebaseDatabase.instance.ref();

  @override
  void initState() {
    super.initState();
    updateTarget(Random().nextInt(10) + 1);
  }

  Future<List<String>> updateQuestion() async {
    return await getQuestionData(widget.gameId);
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
    // nextQuestion();
  }

  void changePlayer() {
    setState(() {
      isGuessing = !isGuessing;
    });
  }

  // void nextQuestion() {
  //   setState(() {
  //     questionsData.removeAt(0);
  //   });
  //   if (questionsData.isEmpty) {
  //     questionsData = makeQuestionList(wavelengthData);
  //     questionsData.shuffle();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wavelength'),
      ),
      body: StreamBuilder(
        stream: databaseReference
            .child('games')
            .child(widget.gameId)
            .onValue
            .map((event) => event.snapshot.value as Map<dynamic, dynamic>),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            questionData =
                (snapshot.data!['game phase'][round]['questionsData'] as List)
                    .map((question) => question.toString())
                    .toList();

            final topic = getQuestionTopic(questionData);
            final scale = getQuestionScale(questionData);
            final bottomLabel = getQuestionBottomLabel(questionData);
            final topLabel = getQuestionTopLabel(questionData);
            return Column(
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
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}

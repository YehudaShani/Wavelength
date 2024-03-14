import 'dart:math';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:wavelength/widgets/question.dart';
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
  bool isGuessing = true;
  List<String> questionData = [];
  final databaseReference = FirebaseDatabase.instance.ref();

  Future<List<String>> updateQuestion() async {
    return await getQuestionData(widget.gameId);
  }

  void updateGuess(int newGuess) {
    setState(() {
      guess = newGuess;
    });
  }

  void checkGuess() {
    int grade = 250 - pow((target - guess), 2) as int;
    if (grade < 0) {
      grade = 0;
    }
    if (guess == target) {
      grade = 500;
    }
    changePlayer();
    saveGuess(widget.gameId, widget.playerName, guess);
    addPointsToPlayer(widget.gameId, widget.playerName, grade);
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
          round = snapshot.data!['current round'];
          if (snapshot.hasData) {
            questionData =
                (snapshot.data!['game phase'][round]['questionsData'] as List)
                    .map((question) => question.toString())
                    .toList();

            final topic = getQuestionTopic(questionData);
            final scale = getQuestionScale(questionData);
            final bottomLabel = getQuestionBottomLabel(questionData);
            final topLabel = getQuestionTopLabel(questionData);
            final passive =
                snapshot.data!['current player'] != widget.playerName;
            target = snapshot.data!['game phase'][round]['target'];
            score = snapshot.data!['scores'][widget.playerName];
            isGuessing = snapshot.data!['guesses'] == null ||
                !snapshot.data!['guesses'].containsKey(widget.playerName);
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
                if (passive && isGuessing)
                  Column(children: [
                    RadialSlider(
                        onChange: updateGuess,
                        bottomLabel: bottomLabel,
                        topLabel: topLabel),
                    ElevatedButton(
                        onPressed: checkGuess, child: const Text('Submit')),
                  ])
                else if (passive && !isGuessing)
                  const Column(children: [
                    Text('Your guess has been submitted!'),
                    Text('Waiting for other players to guess'),
                  ])
                else
                  IconButton(
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

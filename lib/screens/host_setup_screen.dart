import 'dart:math';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:wavelength/screens/game_screen.dart';
import 'package:wavelength/utils/firebase_utils.dart';
import 'package:wavelength/utils/question_utils.dart';
import 'package:wavelength/questions.dart';

final random = Random();
const rounds = 2;

class HostSetupScreen extends StatefulWidget {
  const HostSetupScreen({Key? key}) : super(key: key);
  @override
  _HostSetupScreenState createState() => _HostSetupScreenState();
}

class _HostSetupScreenState extends State<HostSetupScreen> {
  final databaseReference = FirebaseDatabase.instance.ref();
  var gameNumber = random.nextInt(100000).toString();
  bool gameCreated = false;

  String playerName = '';

  void createGame() {
    print('Saving Game Info');
    databaseReference
        .child('games')
        .child(gameNumber)
        .set({
          'host': playerName,
          'players': [playerName],
          'rounds': 5,
          'players joining': true,
          'current round': 1,
        })
        .then((value) => print('Game Info Saved'))
        .catchError((error) => print('Failed to save game info: $error'));
    setState(() {
      gameCreated = true;
    });
  }

  void startGame() async {
    databaseReference
        .child('games')
        .child(gameNumber)
        .update({
          'players joining': false,
        })
        .then((value) => print('Game Started'))
        .catchError((error) => print('Failed to start game: $error'));

    final players = await getPlayers(gameNumber);
    final questionsData = makeQuestionList(wavelengthData);
    final gameDetails = await buildGameMap(questionsData, players, rounds);

    await databaseReference.child('games').child(gameNumber).update({
      'game phase': gameDetails,
    });

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return GameScreen(
        gameId: gameNumber,
        playerName: playerName,
      );
    }), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Host Setup'),
      ),
      body: !gameCreated
          ? (Padding(
              padding: const EdgeInsets.all(40),
              child: Column(children: [
                Center(
                  child: Text(
                    'Ready to host a game?',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  onChanged: (value) {
                    playerName = value;
                  },
                  decoration: InputDecoration(
                    labelText: 'Enter your name',
                    labelStyle: Theme.of(context).textTheme.titleLarge,
                  ),
                ),
                const SizedBox(height: 60),
                ElevatedButton(
                    onPressed: createGame, child: const Text('Start Game')),
              ]),
            ))
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Waiting for players to join...'),
                  const SizedBox(height: 20),
                  Text('Game ID: $gameNumber'),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: startGame,
                    child: const Text('Start Game'),
                  ),
                ],
              ),
            ),
    );
  }
}

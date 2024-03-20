import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:wavelength/screens/game_screen.dart';

class WaitingScreen extends StatefulWidget {
  const WaitingScreen(
      {super.key, required this.gameId, required this.playerName});
  final String gameId;
  final String playerName;

  @override
  State<WaitingScreen> createState() => _WaitingScreenState();
}

class _WaitingScreenState extends State<WaitingScreen> {
  @override
  Widget build(BuildContext context) {
    final databaseReference = FirebaseDatabase.instance
        .ref()
        .child('games')
        .child(widget.gameId)
        .child('players joining');

    return StreamBuilder(
        stream: databaseReference.onValue,
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.snapshot.value == false) {
            return GameScreen(
                gameId: widget.gameId, playerName: widget.playerName);
          }
          return Scaffold(
            appBar: AppBar(
              title: const Text('Waiting for game to start'),
            ),
            body: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Waiting for game to start...'),
                ],
              ),
            ),
          );
        });
  }
}

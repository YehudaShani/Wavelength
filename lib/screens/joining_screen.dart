import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:wavelength/screens/waiting_screen.dart';

class JoiningScreen extends StatefulWidget {
  const JoiningScreen({Key? key}) : super(key: key);

  @override
  State<JoiningScreen> createState() => _JoiningScreenState();
}

class _JoiningScreenState extends State<JoiningScreen> {
  final databaseReference = FirebaseDatabase.instance.ref();
  String gameId = '';
  String name = '';

  void joinGame() {
    if (gameId.isEmpty || name.isEmpty) {
      print('Game ID is empty');
      return;
    }
    print('Joining Game');
    databaseReference.child('games').child(gameId).once().then((snapshot) {
      if (snapshot.snapshot.value != null) {
        print('Game Found');
        // check if the player is already in the game
        final game = snapshot.snapshot.value as Map;
        final players = game['players'] as List<dynamic>;
        if (players.contains(name)) {
          print('Player already in game');
          return;
        }
        final canJoin = game['players joining'] as bool;
        if (!canJoin) {
          print('Game already started');
          return;
        }
        databaseReference.child('games').child(gameId).update({
          'players': [...players, name],
          'scores/$name':
              0, // Add a new score without deleting the existing scores
        }).then((value) => print('Player added to game'));

        Navigator.pushAndRemoveUntil(context,
            MaterialPageRoute(builder: (context) {
          return WaitingScreen(
            gameId: gameId,
            playerName: name,
          );
        }), (route) => false);
      } else {
        print('Game Not Found');
        print(gameId);
        //print all games
        databaseReference.child('games').once().then((snapshot) {
          print(snapshot.snapshot.value);
        });
      }
    }).catchError((error) => print('Failed to join game: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Join Game'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Enter Name:',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (value) {
                  name = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Name',
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                'Enter Game ID:',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 16),
              TextField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  gameId = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Game ID',
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: joinGame,
                child: const Text('Join Game'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

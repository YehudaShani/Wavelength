import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class JoiningScreen extends StatefulWidget {
  const JoiningScreen({Key? key}) : super(key: key);

  @override
  State<JoiningScreen> createState() => _JoiningScreenState();
}

class _JoiningScreenState extends State<JoiningScreen> {
  final databaseReference = FirebaseDatabase.instance.ref();
  String gameId = '';

  void joinGame() {
    if (gameId.isEmpty) {
      print('Game ID is empty');
      return;
    }
    print('Joining Game');
    databaseReference.child('games').child(gameId).once().then((snapshot) {
      if (snapshot.snapshot.value != null) {
        print('Game Found');
        print(snapshot.snapshot.value);
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
                'Enter Game ID:',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 16),
              TextField(
                onChanged: (value) {
                  gameId = value;
                },
                decoration: const InputDecoration(
                  hintText: 'Game ID',
                ),
              ),
              const SizedBox(height: 16),
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

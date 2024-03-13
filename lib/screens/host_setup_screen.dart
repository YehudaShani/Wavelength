import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HostSetupScreen extends StatefulWidget {
  const HostSetupScreen({Key? key}) : super(key: key);
  @override
  _HostSetupScreenState createState() => _HostSetupScreenState();
}

class _HostSetupScreenState extends State<HostSetupScreen> {
  final databaseReference = FirebaseDatabase.instance.ref();

  String playerName = '';

  void startGame() {
    print('Saving Game Info');
    databaseReference
        .child('games')
        .push()
        .set({
          'host': playerName,
          'players': [playerName],
          'rounds': 5,
          'currentQuestion': 0,
        })
        .then((value) => print('Game Info Saved'))
        .catchError((error) => print('Failed to save game info: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Host Setup'),
        ),
        body: Padding(
          padding: EdgeInsets.all(40),
          child: Column(children: [
            Center(
              child: Text(
                'Ready to host a game?',
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) {
                playerName = value;
              },
              decoration: InputDecoration(
                labelText: 'Enter your name',
                labelStyle: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            SizedBox(height: 60),
            ElevatedButton(onPressed: startGame, child: Text('Start Game')),
          ]),
        ));
  }
}

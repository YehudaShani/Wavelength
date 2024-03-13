import 'package:flutter/material.dart';

class OpeningScreen extends StatelessWidget {
  const OpeningScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: AppBar(
        title: Text('Game Title'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Game!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Add logic to start the game
              },
              child: Text('Host Game'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // TODO: Add logic to start the game
              },
              child: Text('Join Game'),
            ),
          ],
        ),
      ),
    );
  }
}

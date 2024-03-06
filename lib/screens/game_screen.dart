import 'package:flutter/material.dart';

class GameScreen extends StatelessWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text('The question'),
        Text('the picture'),
        Text('submit button'),
      ],
    );
  }
}

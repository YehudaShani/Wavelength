import 'dart:math';
import 'package:flutter/material.dart';

class TargetGuess extends StatelessWidget {
  const TargetGuess({Key? key, required this.updateGuess}) : super(key: key);

  final Function(int) updateGuess;

  @override
  Widget build(BuildContext context) {
    int randomNumber = Random().nextInt(10) + 1;

    return InkWell(
      child: Text(
        'Make the person guess the number: $randomNumber',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      onTap: () {
        updateGuess(randomNumber);
      },
    );
  }
}

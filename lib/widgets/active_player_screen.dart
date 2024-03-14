import 'package:flutter/material.dart';

class ActivePlayer extends StatefulWidget {
  const ActivePlayer({super.key, required this.questionData});
  final List<String> questionData;

  @override
  State<ActivePlayer> createState() => _ActivePlayerState();
}

class _ActivePlayerState extends State<ActivePlayer> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text('It is your turn to give the hint!'),
      SizedBox(height: 16),
      Text('The word is: ${widget.questionData[0]}'),
      SizedBox(height: 16),
    ]);
  }
}

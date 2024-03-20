import 'package:flutter/material.dart';

class UpdateScoreScreen extends StatefulWidget {
  const UpdateScoreScreen({
    super.key,
    required this.oldValue,
    required this.newValue,
    required this.guess,
    required this.target,
  });
  final int oldValue;
  final int newValue;
  final int guess;
  final int target;

  @override
  State<UpdateScoreScreen> createState() => _UpdateScoreScreenState();
}

class _UpdateScoreScreenState extends State<UpdateScoreScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Text('Update Score'),
      ),
    );
  }
}

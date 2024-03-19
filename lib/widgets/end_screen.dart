import 'package:flutter/material.dart';

class EndGame extends StatelessWidget {
  const EndGame({super.key, required this.scores});
  final Map<String, int> scores;

  @override
  Widget build(BuildContext context) {
    final sortedScores = scores.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return Center(
      child: Column(
        children: [
          const Text('Game Over!'),
          const SizedBox(height: 16),
          ListView.builder(
            shrinkWrap: true,
            itemCount: sortedScores.length,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    child: Text(
                      index.toString(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(sortedScores[index].key),
                  trailing: Text(sortedScores[index].value.toString()),
                ),
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}

import 'package:firebase_database/firebase_database.dart';

final databaseReference = FirebaseDatabase.instance.ref();

Future<List<String>> getPlayers(String gameId) async {
  final players = await databaseReference
      .child('games')
      .child(gameId)
      .child('players')
      .get();
  return (players.value as List).map((player) => player.toString()).toList();
}

Future<List<String>> getQuestionData(String gameId) async {
  final round = await databaseReference
      .child('games')
      .child(gameId)
      .child('current round')
      .get();

  final questionData = await databaseReference
      .child('games')
      .child(gameId)
      .child('game phase')
      .child(round.value.toString())
      .child('questionsData')
      .get();
  return (questionData.value as List)
      .map((question) => question.toString())
      .toList();
}

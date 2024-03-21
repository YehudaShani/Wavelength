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

Future<List<String>> getGuesses(String gameId) async {
  final guesses = await databaseReference
      .child('games')
      .child(gameId)
      .child('guesses')
      .get();
  return (guesses.value as Map)
      .map((key, value) => MapEntry(key, value.toString()))
      .values
      .toList();
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

void saveGuess(String gameId, String playerName, int guess) async {
  await databaseReference.child('games').child(gameId).child('guesses').update({
    playerName: guess,
  });
  final players = await getPlayers(gameId);
  final amountOfPlayers = players.length;
  final guesses = await getGuesses(gameId);
  final amountOfGuesses = guesses.length;
  print(amountOfPlayers);
  if (amountOfPlayers == amountOfGuesses + 1) {
    startNextRound(gameId);
  }
}

void addPointsToPlayer(String gameId, String playerName, int points) async {
  final score = (await databaseReference
          .child('games')
          .child(gameId)
          .child('scores')
          .child(playerName)
          .get())
      .value as int;

  await databaseReference.child('games').child(gameId).child('scores').update({
    playerName: score + points,
  });
}

void changeToNextPlayer(String gameId) async {
  final players = await getPlayers(gameId);
  final currentPlayer = await databaseReference
      .child('games')
      .child(gameId)
      .child('current player')
      .get();
  final currentPlayerIndex = players.indexOf(currentPlayer.value.toString());
  final nextPlayerIndex = (currentPlayerIndex + 1) % players.length;
  final nextPlayer = players[nextPlayerIndex];
  databaseReference
      .child('games')
      .child(gameId)
      .update({'current player': nextPlayer});
}

void startNextRound(String gameId) async {
  final round = await databaseReference
      .child('games')
      .child(gameId)
      .child('current round')
      .get();
  final currentRound = round.value as int;
  final rounds = await databaseReference
      .child('games')
      .child(gameId)
      .child('rounds')
      .get();
  final amountOfRounds = rounds.value as int;
  if (currentRound == amountOfRounds) {
    endGame(gameId);
  } else {
    databaseReference.child('games').child(gameId).child('guesses').remove();

    databaseReference.child('games').child(gameId).update({
      'current round': currentRound + 1,
    });
    changeToNextPlayer(gameId);
  }
}

void endGame(String gameId) {
  //TODO: implement end game
}

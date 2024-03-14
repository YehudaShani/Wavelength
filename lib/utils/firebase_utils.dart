import 'package:firebase_database/firebase_database.dart';

final databaseReference = FirebaseDatabase.instance.ref();

Future<List<String>> getPlayers(String gameId) async {
  final players = await databaseReference
      .child('games')
      .child(gameId)
      .child('players')
      .get();
  return players.value as List<String>;
}

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HostSetupScreen extends StatefulWidget {
  const HostSetupScreen({Key? key}) : super(key: key);
  @override
  _HostSetupScreenState createState() => _HostSetupScreenState();
}

class _HostSetupScreenState extends State<HostSetupScreen> {
  final databaseReference = FirebaseDatabase.instance.ref();

  String gameName = '';
  String gameDescription = '';

  void saveGameInfo() {
    print('Saving Game Info');
    print(databaseReference.child('game').toString());
    databaseReference
        .child('game')
        .push()
        .set({
          'name': 'gameName',
          'description': 'gameDescription',
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
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Game Name',
              ),
              onChanged: (value) {
                setState(() {
                  gameName = value;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Game Description',
              ),
              onChanged: (value) {
                setState(() {
                  gameDescription = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: saveGameInfo,
              child: Text('Save Game Info'),
            ),
          ],
        ),
      ),
    );
  }
}

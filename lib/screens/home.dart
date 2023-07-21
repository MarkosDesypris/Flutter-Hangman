import 'package:flutter/material.dart';
import 'package:hangman_app/screens/game_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final TextEditingController _wordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            'assets/logo.png',
            color: Colors.white,
          ),
          const SizedBox(height: 10),
          const Text(
            'THE HANGMAN',
            style: TextStyle(
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Divider(
            thickness: 3.0,
            height: 8.0,
          ),
          const SizedBox(height: 20),
          const Text(
            'Please Choose a Word:',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              controller: _wordController,
              textAlign: TextAlign.center,
              decoration: const InputDecoration(
                focusedBorder: OutlineInputBorder(
                  //borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  //borderRadius: BorderRadius.all(Radius.circular(15)),
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        GameScreen(word: _wordController.text),
                  ));
              _wordController.text = '';
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green,
              padding: const EdgeInsets.all(10.0),
            ),
            child: const Text(
              'Start Game',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
          //SizedBox(height: 10)
        ],
      ),
    );
  }
}

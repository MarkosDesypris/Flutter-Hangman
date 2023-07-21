import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:hangman_app/constants/letters.dart';
import 'package:hangman_app/game/figure_widget.dart';
import 'package:hangman_app/game/hidden_letter.dart';
import 'package:hangman_app/style/app_style.dart';

class GameScreen extends StatefulWidget {
  //AudioPlayer audioPlayer = AudioPlayer();
  final String word;
  const GameScreen({super.key, required this.word});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> selectedChar = [];
  int tries = 0;

  void resetGame() {
    setState(() {
      selectedChar = [];
      tries = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hangman: The Game'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => null,
            icon: const Icon(Icons.volume_up_sharp),
            color: Colors.purpleAccent,
          )
        ],
        //elevation: 0,
        //backgroundColor: Colors.transparent,
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              children: [
                Expanded(
                    flex: 3,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        figure(GameUI.hang, tries >= 0),
                        figure(GameUI.head, tries >= 1),
                        figure(GameUI.body, tries >= 2),
                        figure(GameUI.leftArm, tries >= 3),
                        figure(GameUI.rightArm, tries >= 4),
                        figure(GameUI.leftLeg, tries >= 5),
                        figure(GameUI.rightLeg, tries >= 6),
                      ],
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Remaining Tries:',
                      style:
                          TextStyle(fontSize: 18, color: Colors.purpleAccent),
                    ),
                    Text(
                      '  ${6 - tries}',
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    )
                  ],
                ),
                if (widget.word.length < 6)
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: widget.word
                            .toUpperCase()
                            .split('')
                            .map((char) => hiddenLetter(char,
                                selectedChar.contains(char.toUpperCase())))
                            .toList(),
                      ),
                    ),
                  )
                else
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: widget.word
                            .toUpperCase()
                            .substring(0, 6)
                            .split('')
                            .map((char) => hiddenLetter(char,
                                selectedChar.contains(char.toUpperCase())))
                            .toList(),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: widget.word
                            .substring(6)
                            .toUpperCase()
                            .split('')
                            .map((char) => hiddenLetter(char,
                                selectedChar.contains(char.toUpperCase())))
                            .toList(),
                      ),
                    ],
                  )
              ],
            ),
          ),
          SizedBox(height: 40),
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: 4,
                crossAxisSpacing: 4,
                crossAxisCount: 7,
                children: alphabet.map((char) {
                  return ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            selectedChar.contains(char.toUpperCase())
                                ? AppColors.bgColor
                                : Colors.black54),
                    onPressed: () {
                      if (selectedChar.contains(char.toUpperCase())) {
                        return;
                      } else {
                        setState(() {
                          selectedChar.add(char.toUpperCase());
                          if (!widget.word
                              .toUpperCase()
                              .split('')
                              .contains(char.toUpperCase())) {
                            tries++;
                          }
                          if (tries == 6) {
                            // ignore: avoid_single_cascade_in_expression_statements
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.error,
                              animType: AnimType.rightSlide,
                              title: 'You Lose!',
                              desc:
                                  'The hidden word was ${widget.word.toUpperCase()}',
                              btnCancelText: 'Exit',
                              btnCancelOnPress: () {
                                Navigator.pop(context);
                              },
                              btnOkText: 'Try Again!',
                              btnOkOnPress: () {
                                resetGame();
                              },
                            )..show();
                          }
                          if (widget.word.toUpperCase().split('').every(
                              (element) => selectedChar.contains(element))) {
                            // ignore: avoid_single_cascade_in_expression_statements
                            AwesomeDialog(
                              context: context,
                              dialogType: DialogType.success,
                              animType: AnimType.rightSlide,
                              title: 'You Win',
                              btnCancelText: 'Exit',
                              btnCancelOnPress: () {
                                Navigator.pop(context);
                              },
                              btnOkText: 'Play Again!',
                              btnOkOnPress: () {
                                Navigator.pop(context);
                              },
                            )..show();
                          }
                        });
                      }
                    },
                    child: Text(
                      char,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          const SizedBox(height: 20)
        ],
      ),
    );
  }
}

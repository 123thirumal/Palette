import 'package:flutter/material.dart';
import 'dart:math';
import 'package:just_audio/just_audio.dart';

class DiceRoller extends StatefulWidget {
  const DiceRoller(this.number, this.canroll, this.afterRoll, {super.key});

  final int number;
  final int canroll;
  final Function(int) afterRoll; // Callback function

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  var diceImg = 'assets/image/die_1.png';
  final randomizer = Random();
  final player = AudioPlayer(); // just_audio player

  Future<void> roll() async {
    int x = randomizer.nextInt(widget.number - 1) + 1;

    if (widget.canroll == 1) {
      // Play dice roll sound
      try {
        await player.setAsset('assets/sound/die_sound.mp3');
        player.play();
      } catch (e) {
        debugPrint("Error playing sound: $e");
      }

      setState(() {
        switch (x) {
          case 1:
            diceImg = 'assets/image/die_1.png';
            break;
          case 2:
            diceImg = 'assets/image/die_2.png';
            break;
          case 3:
            diceImg = 'assets/image/die_3.png';
            break;
          case 4:
            diceImg = 'assets/image/die_4.png';
            break;
          case 5:
            diceImg = 'assets/image/die_5.png';
            break;
          case 6:
            diceImg = 'assets/image/die_6.png';
            break;
        }
      });

      widget.afterRoll(x);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please swipe'),
          duration: Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  void dispose() {
    player.dispose(); // clean up audio player
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: roll,
      child: Image.asset(diceImg),
    );
  }
}

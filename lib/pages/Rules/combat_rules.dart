import 'package:flutter/material.dart';

class CombatRules extends StatelessWidget {
  const CombatRules({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      body:Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF172155), Color(0xFF41265B)],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
              ),
            ),
          ),
          const Positioned(
            top: 100,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                'Rules',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontFamily: 'Jua',
                ),
              ),
            ),
          ),
          Positioned(
              top: 200,
              left: 10,
              right: 10,
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF030F3A),
                  borderRadius: BorderRadius.circular(12.0), // Adjust the radius as needed
                ),
                child: const Text(
                  '1.Here there will be 2 players. Blue represents player1 and Brown represent player2.\n2. Now player1 has to roll the die and swipe in either of left, right, up, down direction.\n3. Now accordingly the coin will move and colour the board.\n4. Then the chance goes to player2.\n5. Remember once a player swipes in a direction then the chance goes to other player. So think wisely before swiping in any direction.\n6. The player who colours more number of boxes will be the winner. \n7. When the game starts there will be a timer for 60 seconds. Game will get over when the timer goes off.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontFamily: 'Jua',
                  ),
                ),
              )

          ),
        ],
      ),
    );
  }
}

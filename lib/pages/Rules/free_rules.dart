import 'package:flutter/material.dart';

class FreeRules extends StatelessWidget {
  const FreeRules({super.key});

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
              '1. First roll the die.\n2. Then swipe in either of left, right, up, or down direction.\n3. Now the coin will move accordingly and the color of its previous position changes.\n4. The goal is to color as many boxes as possible.',
              style: TextStyle(
                color: Colors.white,
                fontSize: 30,
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

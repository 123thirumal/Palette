import 'package:flutter/material.dart';
import 'package:palette/pages/Rules/free_rules.dart';


import 'free_mode/Free6x6.dart';
import 'free_mode/Free7x7.dart';
import 'free_mode/Free8x8.dart';


class FreeMode extends StatelessWidget {
  const FreeMode({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                'Free Mode',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 50,
                  fontFamily: 'Jua',
                ),
              ),
            ),
          ),
          Positioned(
            top: 270,
            left: 30,
            right: 30,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  Free6x6()));
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                backgroundColor: const Color(0xFF030F3A),
                textStyle: const TextStyle(
                  fontSize: 30,
                  fontFamily: 'Jua',
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text("6X6 grid"),
            ),
          ),
          Positioned(
            top: 420,
            left: 30,
            right: 30,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  Free7x7()));
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                backgroundColor: const Color(0xFF030F3A),
                textStyle: const TextStyle(
                  fontSize: 30,
                  fontFamily: 'Jua',
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text("7X7 grid"),
            ),
          ),
          Positioned(
            top: 570,
            left: 30,
            right: 30,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>  Free8x8()));
              },
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 20),
                backgroundColor: const Color(0xFF030F3A),
                textStyle: const TextStyle(
                  fontSize: 30,
                  fontFamily: 'Jua',
                  color: Colors.white,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: const Text("8X8 grid"),
            ),
          ),
          Positioned(
            top: 720,
            left: 60,
            right: 60,
            child: TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const FreeRules()));
              },
              style: TextButton.styleFrom(
                textStyle: const TextStyle(
                  fontSize: 30,
                  fontFamily: 'Jua',
                ),
                foregroundColor: Colors.white,  // foreground color
                backgroundColor: Colors.transparent,  // background color
              ),
              child: const Text("Rules"),
            ),
          )
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:palette/pages/CombatMode.dart';
import 'package:palette/pages/FreeMode.dart';
import 'package:just_audio/just_audio.dart';

void main() {
  runApp(const Homepage());
}

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() {
    return _HomepageState();
  }
}

class _HomepageState extends State<Homepage> with WidgetsBindingObserver {
  final player = AudioPlayer(); // just_audio player

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    playMusic();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    player.dispose(); // release resources
    super.dispose();
  }

  Future<void> playMusic() async {
    try {
      await player.setAsset("assets/sound/coc_theme.mp3");
      await player.setLoopMode(LoopMode.one); // loop music
      player.play();
    } catch (e) {
      debugPrint("Error playing music: $e");
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      // App came back to foreground → resume music
      player.play();
    } else if (state == AppLifecycleState.paused) {
      // App went to background → pause music
      player.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Builder(
          builder: (context) => Stack(
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
                top: 150,
                left: 0,
                right: 0,
                child: Center(
                  child: Text(
                    "PALETTE",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 50,
                      fontFamily: 'Jua',
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 300,
                left: 30,
                right: 30,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CombatMode()),
                    );
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
                  child: const Text("Combat mode"),
                ),
              ),
              Positioned(
                top: 500,
                left: 30,
                right: 30,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const FreeMode()),
                    );
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
                  child: const Text("Free mode"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:palette/dice%20roller/DiceRoller.dart';

class Free6x6 extends StatefulWidget {
  Free6x6({super.key});

  int canRoll = 1;
  int newSteps = 0;
  int currentRow = 0, currentCol = 0;
  int score = 0;
  int swipecheck=0; //if 0 then swipe is posibble if 1 then not possible

  String check = '';

  @override
  State<Free6x6> createState() => _Free6x6State();
}

class _Free6x6State extends State<Free6x6> {
  late List<List<Image?>> board;
  late List<List<Color?>> boxcolor;
  late Timer _timer;
  int _timerDurationInSeconds = 60; // Set the duration as needed

  @override
  void initState() {
    super.initState();
    _initializeBoard();
    _initializeboxcolor();
    _startTimer();
  }

  void _initializeBoard() {
    // Initialize the position
    List<List<Image?>> newboard =
        List.generate(6, (index) => List.generate(6, (index) => null));

    // Set the center position to an Image asset
    newboard[5][0] = Image.asset('assets/coins/playercoin.png');

    // Update the board
    setState(() {
      board = newboard;
      widget.currentRow = 5;
      widget.currentCol = 0;
    });
  }

  void _initializeboxcolor() {
    List<List<Color?>> newboxcolor =
        List.generate(6, (index) => List.generate(6, (index) => null));

    for (int i = 0; i < 6; i++) {
      for (int j = 0; j < 6; j++) {
        if ((i + j) % 2 == 0) {
          newboxcolor[i][j] = Colors.white70;
        } else {
          newboxcolor[i][j] = Colors.grey;
        }
      }
    }

    setState(() {
      boxcolor = newboxcolor;
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      setState(() {
        if (_timerDurationInSeconds > 0) {
          _timerDurationInSeconds--;
        } else {
          _timer.cancel();
          _showDialog();
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        // Handle horizontal and vertical drags
        onHorizontalDragEnd: (details) {
          horhandleSwipe(details.primaryVelocity!);
        },
        onVerticalDragEnd: (details) {
          verhandleSwipe(details.primaryVelocity!);
        },
        child: Stack(
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
            Positioned(
              top: 220,
              left: 20,
              right: 20,
              bottom: 50,
              child: GridView.builder(
                itemCount: 6 * 6,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 6,
                ),
                itemBuilder: (context, index) {
                  int row = index ~/ 6;
                  int col = index % 6;
                  return Container(
                    color: boxcolor[row][col],
                    child: board[row][col],
                  );
                },
              ),
            ),
            Positioned(
              top: 50,
              right: 0,
              left: 250,
              child: Center(
                child: Text(
                  "Score\n     ${widget.score}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontFamily: 'Jua',
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              right: 250,
              left: 0,
              child: Center(
                child: Text(
                  "Timer\n   $_timerDurationInSeconds",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 35,
                    fontFamily: 'Jua',
                  ),
                ),
              ),
            ),
            Positioned(
              left: 50,
              right: 50,
              bottom: 30,
              child: Center(
                child: DiceRoller(4, widget.canRoll, rollChanger),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void horhandleSwipe(double velocity) {
    if (widget.canRoll == 0) {
      if (velocity > 0) {
        // Swiping right

        for(int i=1;(i<=widget.newSteps)&&(widget.currentCol + widget.newSteps < 6);i++){
          if(boxcolor[widget.currentRow][widget.currentCol+i]==const Color(0xFF1B7499)){
            setState(() {
              widget.swipecheck=1;
            });
          }
        }
        if (widget.swipecheck==1) {
          showNewSnackBar("Not Possible");
          setState(() {
            widget.swipecheck=0;
          });
        } else if (widget.currentCol + widget.newSteps < 6) {
          setState(() {
            //for shifting position
            board[widget.currentRow][widget.currentCol + widget.newSteps] =
                Image.asset('assets/coins/playercoin.png');
            board[widget.currentRow][widget.currentCol] = null;
            //for changing color
            for (int i = 0; i < widget.newSteps; i++) {
              boxcolor[widget.currentRow][widget.currentCol + i] =
                  const Color(0xFF1B7499);
            }

            //for updating position
            widget.currentCol = widget.currentCol + widget.newSteps;

            //for updating score
            setState(() {
              widget.score += widget.newSteps;
            });

            //for updating values
            widget.newSteps = 0;

            //on completion
            if (widget.score == 35) {
              _showDialog();
            }

            widget.canRoll = 1;
          });
        } else {
          showNewSnackBar("Swipe in other directions");
        }
      } else if (velocity < 0) {
        // Swiping left

        for(int i=1;(i<=widget.newSteps)&&(widget.currentCol - widget.newSteps >= 0);i++){
          if(boxcolor[widget.currentRow][widget.currentCol-i]==const Color(0xFF1B7499)){
            setState(() {
              widget.swipecheck=1;
            });
          }
        }

        if (widget.swipecheck==1) {
          showNewSnackBar("Not Possible");
          setState(() {
            widget.swipecheck=0;
          });
        } else if (widget.currentCol - widget.newSteps >= 0) {
          setState(() {
            //for changing position
            board[widget.currentRow][widget.currentCol - widget.newSteps] =
                Image.asset('assets/coins/playercoin.png');
            board[widget.currentRow][widget.currentCol] = null;

            //for changing color
            for (int i = 0; i < widget.newSteps; i++) {
              boxcolor[widget.currentRow][widget.currentCol - i] =
                  const Color(0xFF1B7499);
            }

            //for updating position
            widget.currentCol = widget.currentCol - widget.newSteps;

            //for updating score
            setState(() {
              widget.score += widget.newSteps;
            });

            //for updating values
            widget.newSteps = 0;

            //on completion
            if (widget.score == 35) {
              _showDialog();
            }
            widget.canRoll = 1;
          });
        } else {
          showNewSnackBar("Swipe in other directions");
        }
      }
    } else {
      showNewSnackBar("Please roll the die");
    }
  }

  void verhandleSwipe(double velocity) {
    if (widget.canRoll == 0) {
      if (velocity > 0) {
        // Swiping up

        for(int i=1;(i<=widget.newSteps)&&(widget.currentRow + widget.newSteps < 6);i++){
          if(boxcolor[widget.currentRow+i][widget.currentCol]==const Color(0xFF1B7499)){
            setState(() {
              widget.swipecheck=1;
            });
          }
        }
        if (widget.swipecheck==1) {
          showNewSnackBar("Not Possible");
          setState(() {
            widget.swipecheck=0;
          });
        } else if (widget.currentRow + widget.newSteps < 6) {
          setState(() {
            //for changing position
            board[widget.currentRow + widget.newSteps][widget.currentCol] =
                Image.asset('assets/coins/playercoin.png');
            board[widget.currentRow][widget.currentCol] = null;

            //for changing color
            for (int i = 0; i < widget.newSteps; i++) {
              boxcolor[widget.currentRow + i][widget.currentCol] =
                  const Color(0xFF1B7499);
            }

            //for updating position
            widget.currentRow = widget.currentRow + widget.newSteps;

            //for updating score
            setState(() {
              widget.score += widget.newSteps;
            });

            //for updating values
            widget.newSteps = 0;

            //on completion
            if (widget.score == 35) {
              _showDialog();
            }
            widget.canRoll = 1;
          });
        } else {
          showNewSnackBar("Swipe in other directions");
        }
      } else if (velocity < 0) {
        // Swiping down

        for(int i=1;(i<=widget.newSteps)&&(widget.currentRow - widget.newSteps >= 0);i++){
          if(boxcolor[widget.currentRow-i][widget.currentCol]==const Color(0xFF1B7499)){
            setState(() {
              widget.swipecheck=1;
            });
          }
        }
        if (widget.swipecheck==1) {
          showNewSnackBar("Not Possible");
          setState(() {
            widget.swipecheck=0;
          });
        } else if (widget.currentRow - widget.newSteps >= 0) {
          setState(() {
            //for changing position
            board[widget.currentRow - widget.newSteps][widget.currentCol] =
                Image.asset('assets/coins/playercoin.png');
            board[widget.currentRow][widget.currentCol] = null;

            //for changing color
            for (int i = 0; i < widget.newSteps; i++) {
              boxcolor[widget.currentRow - i][widget.currentCol] =
                  const Color(0xFF1B7499);
            }

            //for updating position
            widget.currentRow = widget.currentRow - widget.newSteps;

            //for updating score
            setState(() {
              widget.score += widget.newSteps;
            });

            //for updating values
            widget.newSteps = 0;

            //on completion
            if (widget.score == 35) {
              _showDialog();
            }
            widget.canRoll = 1;
          });
        } else {
          showNewSnackBar("Swipe in other directions");
        }
      }
    } else {
      showNewSnackBar("Please roll the die");
    }
  }

  void rollChanger(int x) {
    setState(() {
      widget.canRoll = 0;
      widget.newSteps = x;
    });
  }

  void showNewSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration:
            const Duration(milliseconds: 500), // Set the duration as needed
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _showDialog() {
    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    setState(() {
      widget.canRoll = -1;
    });

    showGeneralDialog(
      context: context,
      pageBuilder: (context, animation1, animation2) {
        return Navigator(
          key: navigatorKey,
          onGenerateRoute: (routeSettings) {
            return MaterialPageRoute(
              builder: (context) => _buildDialog(context),
            );
          },
        );
      },
    );
  }

  Widget _buildDialog(BuildContext dialogContext) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF172155), Color(0xFF41265B)],
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Game Over',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'Jua',
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Your score\n ${widget.score}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 25,
                  fontFamily: 'Jua',
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Pop until you reach the HomePage (assuming you want to go back three pages)
                  for (var i = 0; i < 3; i++) {
                    Navigator.of(context).pop();
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  backgroundColor: const Color(0xFF030F3A),
                  textStyle: const TextStyle(
                    fontSize: 20,
                    fontFamily: 'Jua',
                    color: Colors.white,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: const Text("Home"),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

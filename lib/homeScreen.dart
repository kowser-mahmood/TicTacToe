import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int turn = 0;
  List<String> gameBoard = List.filled(9, "");
  String winner = "";

  void _checkWinner() {
    // Check rows
    for (int i = 0; i < 9; i += 3) {
      if (gameBoard[i] != "" &&
          gameBoard[i] == gameBoard[i + 1] &&
          gameBoard[i + 1] == gameBoard[i + 2]) {
        setState(() {
          winner = gameBoard[i];
        });
        return;
      }
    }

    // Check columns
    for (int i = 0; i < 3; i++) {
      if (gameBoard[i] != "" &&
          gameBoard[i] == gameBoard[i + 3] &&
          gameBoard[i + 3] == gameBoard[i + 6]) {
        setState(() {
          winner = gameBoard[i];
        });
        return;
      }
    }

    // Check diagonals
    if (gameBoard[0] != "" &&
        gameBoard[0] == gameBoard[4] &&
        gameBoard[4] == gameBoard[8]) {
      setState(() {
        winner = gameBoard[0];
      });
      return;
    }

    if (gameBoard[2] != "" &&
        gameBoard[2] == gameBoard[4] &&
        gameBoard[4] == gameBoard[6]) {
      setState(() {
        winner = gameBoard[2];
      });
      return;
    }

    // Check for a tie
    if (!gameBoard.contains("")) {
      setState(() {
        winner = "Tie";
      });
    }
  }

  void _handleTap(int index) {
    if (winner != "" || gameBoard[index] != "") return;

    setState(() {
      if (turn == 0) {
        gameBoard[index] = "X";
        turn = 1;
      } else {
        gameBoard[index] = "O";
        turn = 0;
      }
    });

    _checkWinner();
  }

  void _resetGame() {
    setState(() {
      turn = 0;
      gameBoard = List.filled(9, "");
      winner = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 171, 109, 27),
            Color.fromARGB(255, 33, 51, 69),
          ],
          begin: Alignment.topRight,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Center(
        child: Container(
          width: 600,
          height: 600,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(45),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (winner != "")
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Text(
                    winner == "Tie" ? "It's a Tie!" : "Winner: $winner",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: winner == "X" ? Colors.blue : Colors.red,
                    ),
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BuildButton(index: 0, onTap: _handleTap, text: gameBoard[0]),
                  BuildButton(index: 1, onTap: _handleTap, text: gameBoard[1]),
                  BuildButton(index: 2, onTap: _handleTap, text: gameBoard[2]),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BuildButton(index: 3, onTap: _handleTap, text: gameBoard[3]),
                  BuildButton(index: 4, onTap: _handleTap, text: gameBoard[4]),
                  BuildButton(index: 5, onTap: _handleTap, text: gameBoard[5]),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BuildButton(index: 6, onTap: _handleTap, text: gameBoard[6]),
                  BuildButton(index: 7, onTap: _handleTap, text: gameBoard[7]),
                  BuildButton(index: 8, onTap: _handleTap, text: gameBoard[8]),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5),
                child: ResetButton(onPressed: _resetGame),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BuildButton extends StatelessWidget {
  const BuildButton({
    super.key,
    required this.index,
    required this.onTap,
    required this.text,
  });

  final int index;
  final Function(int) onTap;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: ElevatedButton(
        onPressed: () => onTap(index),
        style: ElevatedButton.styleFrom(fixedSize: const Size(120, 120)),
        child: Text(
          text,
          style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class ResetButton extends StatelessWidget {
  const ResetButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: const Text("Reset",
          style: TextStyle(fontSize: 40, color: Colors.black)),
    );
  }
}
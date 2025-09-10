import 'dart:math';
import 'package:flutter/material.dart';
import 'package:my_app/constants.dart' as constants;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Color color = constants.purple;

  late List<Color> cellColors;
  late List<int> cellNumbers;

  @override
  void initState() {
    super.initState();

    cellColors = [
      Colors.purple,
      Colors.blue,
      Colors.pink,
      Colors.green,
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.deepPurple,
      Colors.cyan,
      Colors.redAccent,
      Colors.lime,
      Colors.pinkAccent,
      Colors.purpleAccent,
      Colors.teal,
      Colors.deepOrange,
      Colors.blueAccent,
      Colors.lightGreen,
      Colors.pinkAccent,
    ];

    cellNumbers = List.generate(18, (index) => index + 1);
  }

  void _swapNumbers(int topIndex, int bottomIndex) {
    setState(() {
      int temp = cellNumbers[topIndex];
      cellNumbers[topIndex] = cellNumbers[bottomIndex];
      cellNumbers[bottomIndex] = temp;
    });
  }

  void _swapColors(int firstIndex, int secondIndex) {
    setState(() {
      Color temp = cellColors[firstIndex];
      cellColors[firstIndex] = cellColors[secondIndex];
      cellColors[secondIndex] = temp;
    });
  }

  Color _generateRandomColor() {
    final Random random = Random();
    return Color.fromRGBO(
      random.nextInt(256),
      random.nextInt(256),
      random.nextInt(256),
      1.0,
    );
  }

  void _changeToRandomColor(int position) {
    setState(() {
      cellColors[position] = _generateRandomColor();
    });
  }

  void _shuffleAllColors() {
    setState(() {
      List<Color> originalColors = List.from(cellColors);
      cellColors.shuffle(Random());

      while (_listsAreEqual(cellColors, originalColors)) {
        cellColors.shuffle(Random());
      }
    });
  }

  void _shuffleAllNumbers() {
    setState(() {
      List<int> shuffledNumbers = List.generate(18, (index) => index + 1);
      shuffledNumbers.shuffle(Random());

      while (_listsAreEqual(shuffledNumbers, cellNumbers)) {
        shuffledNumbers.shuffle(Random());
      }
      cellNumbers = shuffledNumbers;
    });
  }

  void _randomizeEverything() {
    _shuffleAllColors();
    _shuffleAllNumbers();
  }

  bool _listsAreEqual<T>(List<T> list1, List<T> list2) {
    if (list1.length != list2.length) return false;
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) return false;
    }
    return true;
  }

  Widget _buildGridCell(int position) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (position == 0) {
            _swapNumbers(0, 15);
          } else if (position == 1) {
            _swapNumbers(1, 16);
          } else if (position == 2) {
            _swapNumbers(2, 17);
          } else if (position == 6) {
            _swapColors(6, 8);
          } else if (position == 8) {
            _swapColors(6, 8);
          } else if (position == 7) {
            _changeToRandomColor(7);
          } else if (position == 13) {
            _randomizeEverything();
          } else {
            setState(() {});
          }
        },
        child: Container(
          color: cellColors[position],
          child: Center(
            child: Text(
              '${cellNumbers[position]}',
              style: TextStyle(
                color: constants.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                _buildGridCell(0),
                _buildGridCell(1),
                _buildGridCell(2),
              ],
            ),
          ),

          Expanded(
            child: Row(
              children: [
                _buildGridCell(3),
                _buildGridCell(4),
                _buildGridCell(5),
              ],
            ),
          ),

          Expanded(
            child: Row(
              children: [
                _buildGridCell(6),
                _buildGridCell(7),
                _buildGridCell(8),
              ],
            ),
          ),

          Expanded(
            child: Row(
              children: [
                _buildGridCell(9),
                _buildGridCell(10),
                _buildGridCell(11),
              ],
            ),
          ),

          Expanded(
            child: Row(
              children: [
                _buildGridCell(12),
                _buildGridCell(13),
                _buildGridCell(14),
              ],
            ),
          ),

          Expanded(
            child: Row(
              children: [
                _buildGridCell(15),
                _buildGridCell(16),
                _buildGridCell(17),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

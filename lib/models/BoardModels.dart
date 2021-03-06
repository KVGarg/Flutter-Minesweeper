
import 'package:flutter/material.dart';

// The Square Size - Row/Columns, and the number of mines in the selected game difficulty level
class LevelSizeAndMines {
  int size, mines;

  LevelSizeAndMines({this.size, this.mines});
}

class BoardSquare {
  bool isPopped;
  bool isFlagged;
  bool isSelfMine;
  Widget cellView;
  bool isStateChanged;
  Widget grassCellView;
  int neighbourMinesCount;

  BoardSquare({
    this.neighbourMinesCount = 0,
    this.isSelfMine = false,
    this.cellView,
    this.isPopped = false,
    this.isFlagged = false,
    this.isStateChanged = true,
  });
}

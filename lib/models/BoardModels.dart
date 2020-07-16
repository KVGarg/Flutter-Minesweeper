
import 'package:flutter/material.dart';

class LevelSizeAndMines {
  int size, mines;

  LevelSizeAndMines({this.size, this.mines});
}

class BoardSquare {
  int neighbourMinesCount;
  bool isSelfMine;
  bool isPopped;
  bool isFlagged;
  Widget cellView;

  BoardSquare({
    this.neighbourMinesCount = 0,
    this.isSelfMine = false,
    this.cellView,
    this.isPopped = false,
    this.isFlagged = false
  });
}

import 'dart:math';

import 'package:Minesweeper/models/BoardModels.dart';
import 'package:Minesweeper/utils/appConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MinesweeperMatrix {

  int movesLeft;
  int flagsLeft;
  Size screenSize;
  int squaresPopped = 0;
  int bombsDiffused = 0;
  bool gameWon = false;
  bool gameOver = false;
  double cellWidth, cellHeight;
  LevelSizeAndMines sizeAndMines;
  Map<int, List<int>> minesPosition = Map();
  List<List<BoardSquare>> minesInCellNeighbours = List();

  MinesweeperMatrix({@required int gameLevel, @required this.screenSize}) {
    switch (gameLevel) {
      case 1: {
        sizeAndMines = LevelSizeAndMines(size: LevelSize.beginner, mines: LevelMines.beginner);
       break;
      }
      case 2: {
        sizeAndMines = LevelSizeAndMines(size: LevelSize.intermediate,
          mines: LevelMines.intermediate);
       break;
      }
      case 3: {
        sizeAndMines = LevelSizeAndMines(size: LevelSize.advanced, mines: LevelMines.advanced);
       break;
      }
    }
    // 24 -> 12.0 Symmetric padding from left and right
    cellWidth = (screenSize.width - 24) / sizeAndMines.size;
    cellHeight = (screenSize.height * 0.75) / sizeAndMines.size;

    flagsLeft = sizeAndMines.mines;
    movesLeft = (sizeAndMines.size * sizeAndMines.size) - sizeAndMines.mines;

    findRandomPositionsOfMines();
    findNeighbouringMines();
  }

  findRandomPositionsOfMines() {
    int numberOfMinesPlaced = 0, x, y;
    while (numberOfMinesPlaced != sizeAndMines.mines) {
      x = Random().nextInt(sizeAndMines.size);
      y = Random().nextInt(sizeAndMines.size);
      if (!minesPosition.containsKey(x)) {
        minesPosition[x] = [y, ];
        numberOfMinesPlaced++;
      } else if (minesPosition.containsKey(x) && !minesPosition[x].contains(y)) {
        minesPosition[x].add(y);
        numberOfMinesPlaced++;
      }
    }
  }

  findNeighbouringMines() {
    int minesInNeighbour = 0;
    bool isMineCell = false;
    for (int row = 0; row < sizeAndMines.size; row++) {
      minesInCellNeighbours.insert(row, List());
      for (int column = 0; column < sizeAndMines.size; column++) {

        // Check mines in NW
        if (minesPosition.containsKey(row-1) && minesPosition[row-1].contains(column-1))
          minesInNeighbour += 1;
        // Check mines in N
        if (minesPosition.containsKey(row-1) && minesPosition[row-1].contains(column))
          minesInNeighbour += 1;
        // Check mines in NE
        if (minesPosition.containsKey(row-1) && minesPosition[row-1].contains(column+1))
          minesInNeighbour += 1;
        // Check mines in W
        if (minesPosition.containsKey(row) && minesPosition[row].contains(column-1))
          minesInNeighbour += 1;
        // Check mines in E
        if (minesPosition.containsKey(row) && minesPosition[row].contains(column+1))
          minesInNeighbour += 1;
        // Check mines in SW
        if (minesPosition.containsKey(row+1) && minesPosition[row+1].contains(column-1))
          minesInNeighbour += 1;
        // Check mines in S
        if (minesPosition.containsKey(row+1) && minesPosition[row+1].contains(column))
          minesInNeighbour += 1;
        // Check mines in SE
        if (minesPosition.containsKey(row+1) && minesPosition[row+1].contains(column+1))
          minesInNeighbour += 1;
        // Check whether self-cell has mine or not
        if (minesPosition.containsKey(row) && minesPosition[row].contains(column))
          isMineCell = true;

        minesInCellNeighbours[row].add(BoardSquare(
          neighbourMinesCount: minesInNeighbour,
          isSelfMine: isMineCell,
        ));
      }
    }
  }

}
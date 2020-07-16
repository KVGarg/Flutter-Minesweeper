import 'dart:math';

import 'package:Minesweeper/models/BoardModels.dart';
import 'package:Minesweeper/services/manageSoundAndVibrations.dart';
import 'package:Minesweeper/utils/appConstants.dart';
import 'package:Minesweeper/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class MinesweeperMatrix {

  int movesLeft;
  int flagsLeft;
  Size screenSize;
  bool isEvenCell;
  int squaresPopped = 0;
  int bombsDiffused = 0;
  bool gameWon = false;
  BoardSquare boardSquare;
  double cellWidth, cellHeight;
  LevelSizeAndMines sizeAndMines;
  Map<int, List<int>> minesPosition = Map();
  Color darkEmptyCellColor = Color(0xffd7b899);
  Color lightEmptyCellColor = Color(0xfff1ceab);
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
    int maximumMinesInARow = sqrt(sizeAndMines.mines).toInt();
    while (numberOfMinesPlaced != sizeAndMines.mines) {
      x = Random().nextInt(sizeAndMines.size);
      y = Random().nextInt(sizeAndMines.size);
      if (!minesPosition.containsKey(x)) {
        minesPosition[x] = [y, ];
        numberOfMinesPlaced++;
      } else if (minesPosition.containsKey(x)
        && minesPosition[x].length <= maximumMinesInARow
        && !minesPosition[x].contains(y)) {
        minesPosition[x].add(y);
        numberOfMinesPlaced++;
      }
    }
  }

  findNeighbouringMines() {
    int minesInNeighbour;
    bool isMineCell = false;
    for (int row = 0; row < sizeAndMines.size; row++) {
      minesInCellNeighbours.insert(row, List());
      for (int column = 0; column < sizeAndMines.size; column++) {
        minesInNeighbour = 0;
        isEvenCell = (row + column) % 2 == 0;
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
        else
          isMineCell = false;

        minesInCellNeighbours[row].add(BoardSquare(
          neighbourMinesCount: minesInNeighbour,
          isSelfMine: isMineCell,
          cellView: getCellView(isMineCell: isMineCell, neighbours: minesInNeighbour),
        ));
      }
    }
  }

  getCellView({@required bool isMineCell, @required int neighbours}) {
    if (isMineCell) {

      return Container(
        width: cellWidth,
        height: cellHeight,
        color: isEvenCell ? darkEmptyCellColor : lightEmptyCellColor,
        child: new Image.asset(getImageFilePath(ImageType.APP_LOGO)),
      );

    } else if (neighbours > 0) {

      return Container(
        width: cellWidth,
        height: cellHeight,
        alignment: Alignment.center,
        color: isEvenCell ? darkEmptyCellColor : lightEmptyCellColor,
        child: Text('$neighbours',
          textAlign: TextAlign.center,
          style: getTextStyleSettings(
            fontSize: sizeAndMines.size > 20 ? FontSize.SMALL : FontSize.MEDIUM,
            fontColor: NeighbourDensityBasedColor().getColorFromIndex(index: neighbours)
          ),
        ),
      );

    } else {

      return Container(
        width: cellWidth,
        height: cellHeight,
        color: isEvenCell ? darkEmptyCellColor : lightEmptyCellColor,
      );

    }
  }

  Future<void> handleMineExplosion({bool playVibrationAndSound: true}) async {
    if (playVibrationAndSound) {
      playVibration();
      playSound(fileName: GameSounds.EXPLOSION_SOUND_FP);
    }
    minesPosition.forEach((rowNumber, columnNumbers) async {
      await Future.forEach(columnNumbers, (columnNumber) async {
        boardSquare = minesInCellNeighbours[rowNumber][columnNumber];
        boardSquare.isPopped = true;
        boardSquare.isStateChanged = true;
      });
    });
  }

  Future<void> digTheGrassAndExposeNeighbours(int xCord, int yCord) async {

    for (int row = xCord - 1; row <= xCord + 1; row++) {
      for (int column = yCord - 1; column <= yCord + 1; column++) {
        if (!(row == xCord && column == yCord)
              && (row > -1 && row < sizeAndMines.size)
              && (column > -1 && column < sizeAndMines.size)) {
          boardSquare = minesInCellNeighbours[row][column];
          if (boardSquare.neighbourMinesCount >= 0
              && !boardSquare.isSelfMine && !boardSquare.isFlagged && !boardSquare.isPopped) {
            squaresPopped += 1;
            movesLeft -= 1;
            boardSquare.isStateChanged = true;
            boardSquare.isPopped = true;
            if (boardSquare.neighbourMinesCount == 0)
              await digTheGrassAndExposeNeighbours(row, column);
          }
        } else {
          squaresPopped += 1;
          movesLeft -= 1;
          boardSquare = minesInCellNeighbours[xCord][yCord];
          boardSquare.isStateChanged = true;
          boardSquare.isPopped = true;
        }
      }
    }
    return;

  }

  Future<void> hideCellsAndShowOnlyMines() async {
    Future.forEach(minesInCellNeighbours, (List<BoardSquare> rowBoardSquares) async {
      await Future.forEach(rowBoardSquares, (BoardSquare boardSquare) async {
        boardSquare.isPopped = boardSquare.isSelfMine;
        boardSquare.isFlagged = false;
        boardSquare.isStateChanged = true;
      });
    });
    flagsLeft = bombsDiffused = sizeAndMines.mines;
  }

}

class LevelSizeAndMines {
  int size, mines;

  LevelSizeAndMines({this.size, this.mines});
}

class BoardSquare {
  int neighbourMinesCount;
  bool isSelfMine;
  bool isPopped;
  bool isFlagged;

  BoardSquare({
    this.neighbourMinesCount = 0,
    this.isSelfMine = false,
    this.isPopped = false,
    this.isFlagged = false
  });
}

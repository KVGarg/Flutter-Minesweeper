import 'dart:async';
import 'dart:io';

import 'package:Minesweeper/models/BoardModels.dart';
import 'package:Minesweeper/services/gameStatistics.dart';
import 'package:Minesweeper/services/manageSoundAndVibrations.dart';
import 'package:Minesweeper/services/prepareBoardMatrix.dart';
import 'package:Minesweeper/utils/appConstants.dart';
import 'package:Minesweeper/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class StartGame extends StatefulWidget {
  @override
  _StartGameState createState() => _StartGameState();
}

class _StartGameState extends State<StartGame> {
  Size screenSize;
  Timer _gameTimer;
  Widget emptyCellWidget;
  BoardSquare boardSquare;
  int totalSecondsPlayed = 0;
  bool isNextCellDark = false;
  bool firstSquarePopped = false;
  MinesweeperMatrix minesweeperMatrix;

  @override
  Widget build(BuildContext context) {
    if (minesweeperMatrix == null) {
      screenSize = MediaQuery.of(context).size;
      minesweeperMatrix = ModalRoute.of(context).settings.arguments;
    }

    return Scaffold(
      backgroundColor: WHITE_COLOR,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              new Image.asset(getImageFilePath(ImageType.APP_LOGO), width: 50),
              Text('Minesweeper Board Game', style: getTextStyleSettings(),)
            ],
          ),
          Container(
            alignment: Alignment.center,
            color: Colors.green.shade900,
            height: 60,
            width: screenSize.width,
            child: getTimerAndOtherOptions(),
          ),
          Container(
            color: Colors.green.shade700,
            width: screenSize.width,
            height: screenSize.height - 106,
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: prepareGameBoardWidget()
            ),
          )
        ],
      ),
    );
  }

  Widget getTimerAndOtherOptions() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            new Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new Image.asset(getImageFilePath(ImageType.FLAG_ICON), width: 50),
                new Text(
                  minesweeperMatrix.flagsLeft.toString(),
                  style: getTextStyleSettings(
                    fontSize: FontSize.MEDIUM * 1.5,
                    fontColor: WHITE_COLOR
                  )
                ),
                new Image.asset(getImageFilePath(ImageType.CLOCK_ICON), width: 50),
                new Text(
                  totalSecondsPlayed.toString(),
                  style: getTextStyleSettings(
                    fontSize: FontSize.MEDIUM * 1.5,
                    fontColor: WHITE_COLOR
                  )
                ),
              ],
            ),
            new Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                new IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(playSounds ? Icons.volume_up : Icons.volume_off,
                    size: IconSize.MEDIUM,
                    color: WHITE_COLOR,),
                  onPressed: () {
                    setState(() {
                      toggleAppSounds();
                    });
                  }),
                new IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(playVibrations ? Icons.vibration : Icons.phone_iphone,
                    size: IconSize.MEDIUM,
                    color: WHITE_COLOR,),
                  onPressed: () {
                    setState(() {
                      toggleAppVibrations();
                    });
                  }),
              ],
            )
          ],
        ),
      ],
    );
  }

  prepareGameBoardWidget() {
    List<Widget> grassRows = List();
    List<Widget> eachGrassRow = List();
    for (int row = 0; row < minesweeperMatrix.sizeAndMines.size; row++) {
      for (int column = 0; column < minesweeperMatrix.sizeAndMines.size; column++) {
        boardSquare = minesweeperMatrix.minesInCellNeighbours[row][column];
        eachGrassRow.add(Container(
          width: minesweeperMatrix.cellWidth,
          height: minesweeperMatrix.cellHeight,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            children: <Widget>[
              boardSquare.cellView,
              boardSquare.isStateChanged
              ? getGrassImageContainer(isEvenCell: isNextCellDark, xCord: row, yCord: column)
              : boardSquare.grassCellView,
            ],
          ),
        ));
        isNextCellDark = !isNextCellDark;
      }
      if (minesweeperMatrix.sizeAndMines.size % 2 == 0) {
        isNextCellDark = !isNextCellDark;
      }
      grassRows.add(new Row(mainAxisSize: MainAxisSize.min, children: eachGrassRow));
      eachGrassRow = List();
    }

    isNextCellDark = false;
    return new Column(mainAxisSize: MainAxisSize.max, children: grassRows);
  }

  getGrassImageContainer({@required bool isEvenCell, @required int xCord, @required int yCord}) {
    Widget grassCellView;
    if (boardSquare.isPopped) {
      grassCellView = Container();
    } else {
      if (!minesweeperMatrix.gameWon && boardSquare.isFlagged) {
        grassCellView = Container(
          width: minesweeperMatrix.cellWidth,
          height: minesweeperMatrix.cellHeight,
          alignment: Alignment.center,
          child: FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: () {},
            child: Stack(
              alignment: Alignment.center,
              children: <Widget>[
                new Image.asset(
                  getImageFilePath(isEvenCell ? ImageType.DARK_GRASS : ImageType.LIGHT_GRASS),
                  width: minesweeperMatrix.cellWidth,
                  height: minesweeperMatrix.cellHeight,
                  fit: BoxFit.fill,),
                new Image.asset(getImageFilePath(ImageType.FLAG_ICON),
                  width: minesweeperMatrix.sizeAndMines.size > 20
                    ? IconSize.MEDIUM : IconSize.LARGE,
                  fit: BoxFit.fill,),
              ],
            ),
          ),
        );
      } else  if (!minesweeperMatrix.gameWon && boardSquare.isFlagged) {
        grassCellView = Container(
          width: minesweeperMatrix.cellWidth,
          height: minesweeperMatrix.cellHeight,
          child: FlatButton(
            padding: EdgeInsets.all(0),
            onPressed: () => popSquare(xCord, yCord),
            onLongPress: () {},
            child: new Image.asset(
              getImageFilePath(isEvenCell ? ImageType.DARK_GRASS : ImageType.LIGHT_GRASS),
              width: minesweeperMatrix.cellWidth,
              height: minesweeperMatrix.cellHeight,
              fit: BoxFit.fill,),
          ),
        );
      } else if (minesweeperMatrix.gameWon) {
        grassCellView = Container(
          width: minesweeperMatrix.cellWidth,
          height: minesweeperMatrix.cellHeight,
          child: Stack(
            fit: StackFit.expand,
            alignment: Alignment.center,
            overflow: Overflow.visible,
            children: <Widget>[
              new Image.asset(
                getImageFilePath(isEvenCell ? ImageType.DARK_GRASS : ImageType.LIGHT_GRASS),
                fit: BoxFit.fill),
              new Container(
                width: minesweeperMatrix.cellWidth,
                height: minesweeperMatrix.cellHeight,
                color: GREEN_COLOR.withOpacity(0.8),
              )
            ]),
        );
      }
    }

    boardSquare.grassCellView = grassCellView;
    boardSquare.isStateChanged = false;
    return grassCellView;
  }

  void startTimerIFirstSquarePopped() {
    if (!firstSquarePopped) {
      totalSecondsPlayed += 1;
      _gameTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
        if (!mounted) return;
        setState(() {
          totalSecondsPlayed += 1;
        });
      });
      firstSquarePopped = !firstSquarePopped;
    }
  }

  Future<void> popSquare(int xCord, int yCord) async {
    startTimerIFirstSquarePopped();
    boardSquare = minesweeperMatrix.minesInCellNeighbours[xCord][yCord];
    boardSquare.isStateChanged = true;
    boardSquare.isPopped = true;

    if (boardSquare.isSelfMine) {
      _gameTimer.cancel();
      await minesweeperMatrix.handleMineExplosion();
      setState(() {});
      await showGamePlayDialog();
      Navigator.of(context).pop();
    } else {
      playSound(fileName: GameSounds.DIGGING_SOUND_FP);
      playVibration();
      if (boardSquare.neighbourMinesCount == 0)
        await minesweeperMatrix.digTheGrassAndExposeNeighbours(xCord, yCord);
      setState(() {});
      if (minesweeperMatrix.movesLeft <= 0) await _handleWin();
    }
  }

  void flagSquare(int xCord, int yCord) {
    startTimerIFirstSquarePopped();
  }

  @override
  void dispose() {
    super.dispose();
    storeCurrentGameStatistics();
    if (_gameTimer != null)
      _gameTimer.cancel();
  }

  void storeCurrentGameStatistics() {
    if (totalSecondsPlayed > 0)
      setGameStatistics(updatedStats: {
        'total_time_played': totalSecondsPlayed,
        'squares_popped': minesweeperMatrix.squaresPopped,
        'diffused_bombs': minesweeperMatrix.bombsDiffused,
        minesweeperMatrix.gameWon ? 'wins' : 'loses': 1,
      });
  }

  Future<void> _handleWin() async {
    minesweeperMatrix.gameWon = true;
    playSound(fileName: GameSounds.WIN_SOUND_FP);
    await minesweeperMatrix.hideCellsAndShowOnlyMines();
    setState(() {});
    await showGamePlayDialog();
    Navigator.of(context).pop();
  }

  Future<void> showGamePlayDialog() async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext buildContext) {
        return Platform.isIOS
          ? CupertinoAlertDialog(
              title: Text(minesweeperMatrix.gameWon ? 'Congratulations' : 'Mine Exploded!',
                style: getTextStyleSettings(
                  fontColor: minesweeperMatrix.gameWon ? GREEN_COLOR: RED_ACCENT_COLOR)),
              content: getGamePlayDialogContent(),
              actions: <Widget>[
                CupertinoDialogAction(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Try again?',
                    style: getTextStyleSettings(fontColor: GREEN_COLOR),
                  ))
              ])
          : AlertDialog(
              title: Text(minesweeperMatrix.gameWon ? 'Congratulations' : 'Mine Exploded!',
                style: getTextStyleSettings(
                  fontColor: minesweeperMatrix.gameWon ? GREEN_COLOR: RED_ACCENT_COLOR)),
              content: getGamePlayDialogContent(),
              actions: <Widget>[
                FlatButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: Text(
                    'Try again?',
                    style: getTextStyleSettings(fontColor: GREEN_COLOR),
                  ))
              ]);
      });
  }


  Widget getGamePlayDialogContent() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(minesweeperMatrix.gameWon ? GameMessages.WIN : GameMessages.LOSE,
          style: getTextStyleSettings(),
          textAlign: TextAlign.justify,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: new Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Image.asset(
                    getImageFilePath(ImageType.CLOCK_ICON),
                    width: 50,
                  ),
                  Text('$totalSecondsPlayed',
                    style: getTextStyleSettings(fontSize: FontSize.MEDIUM * 1.5))
                ],
              ),
              new Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  new Image.asset(getImageFilePath(ImageType.TROPHY_ICON), width: 50),
                  Text(
                    '${minesweeperMatrix.squaresPopped}',
                    style: getTextStyleSettings(fontSize: FontSize.MEDIUM * 1.5),
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

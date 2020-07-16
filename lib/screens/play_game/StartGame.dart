import 'dart:async';

import 'package:Minesweeper/services/gameStatistics.dart';
import 'package:Minesweeper/services/manageSoundAndVibrations.dart';
import 'package:Minesweeper/services/prepareBoardMatrix.dart';
import 'package:Minesweeper/utils/appConstants.dart';
import 'package:Minesweeper/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StartGame extends StatefulWidget {
  @override
  _StartGameState createState() => _StartGameState();
}

class _StartGameState extends State<StartGame> {

  Size screenSize;
  Timer _gameTimer;
  Widget emptyCellWidget;
  int totalSecondsPlayed = 0;
  bool isNextCellDark = false;
  bool firstSquarePopped = false;
  MinesweeperMatrix minesweeperMatrix;
  Color darkEmptyCellColor = Color(0xffd7b899);
  Color lightEmptyCellColor = Color(0xfff1ceab);

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

    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: minesweeperMatrix.sizeAndMines.size * minesweeperMatrix.sizeAndMines.size,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: minesweeperMatrix.sizeAndMines.size,
      ),
      itemBuilder: (context, position) {
        int rowNumber = (position / minesweeperMatrix.sizeAndMines.size).floor();
        int columnNumber = (position % minesweeperMatrix.sizeAndMines.size);
        isNextCellDark = (rowNumber + columnNumber) % 2 == 0;
        return Container(
          width: minesweeperMatrix.cellWidth,
          height: minesweeperMatrix.cellHeight,
          child: FlatButton(
            onPressed: () => popSquare(rowNumber, columnNumber),
            onLongPress: () => flagSquare(rowNumber, columnNumber),
            padding: EdgeInsets.all(0),
            child: new Image.asset(isNextCellDark
                ? getImageFilePath(ImageType.DARK_GRASS): getImageFilePath(ImageType.LIGHT_GRASS),
              width: minesweeperMatrix.cellWidth,
              height: minesweeperMatrix.cellHeight,
              fit: BoxFit.fill,
            ),
          )
        );
      }
    );

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

  void popSquare(int xCord, int yCord) {
    startTimerIFirstSquarePopped();
  }

  void flagSquare(int xCord, int yCord) {
    startTimerIFirstSquarePopped();
  }

  @override
  void dispose() {
    super.dispose();
    storeCurrentGameStatistics();
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
}

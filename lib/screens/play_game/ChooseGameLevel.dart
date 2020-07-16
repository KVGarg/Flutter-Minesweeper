import 'dart:async';

import 'package:Minesweeper/services/gameStatistics.dart';
import 'package:Minesweeper/services/manageSoundAndVibrations.dart';
import 'package:Minesweeper/services/manageBoardMatrix.dart';
import 'package:Minesweeper/utils/appConstants.dart';
import 'package:Minesweeper/utils/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ChooseGameLevel extends StatefulWidget {
  @override
  _ChooseGameLevelState createState() => _ChooseGameLevelState();
}

class _ChooseGameLevelState extends State<ChooseGameLevel> {

  Size screenSize;
  bool isLevelSelected;

  @override
  void didChangeDependencies() {
    isLevelSelected = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Scaffold(
          appBar: getAppBar(title: 'Game Level'),
          body: Container(
            color: WHITE_COLOR,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                getGameLevelOption(
                  buttonLabel: 'Beginner', bgColor: GREEN_COLOR, gameLevel: GameLevels.beginner),
                SizedBox(height: 10),
                getGameLevelOption(
                  buttonLabel: 'Intermediate', bgColor: ACCENT_COLOR,
                  gameLevel: GameLevels.intermediate),
                SizedBox(height: 10),
                getGameLevelOption(
                  buttonLabel: 'Advanced', bgColor: RED_ACCENT_COLOR,
                  gameLevel: GameLevels.advanced),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Text(
                    'NOTE: Please read the instructions of the game play, if you are not aware about '
                      'the minesweeper board game. The instruction are available in the menu.\nGood Win!',
                    textAlign: TextAlign.center,
                    style: getTextStyleSettings(fontSize: FontSize.SMALL, fontFamily: 'Comfortaa'),
                  ),
                )
              ],
            ),
          ),
        ),
        getAnimatedLoader(isFormSubmitted: isLevelSelected)
      ],
    );
  }

  getGameLevelOption({@required buttonLabel, @required bgColor, @required int gameLevel}) {
    return FlatButton(
      padding: EdgeInsets.all(24.0),
      color: bgColor,
      textColor: WHITE_COLOR,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: BLACK_87_COLOR),
        borderRadius: BorderRadius.circular(12.0)
      ),
      onPressed: () {
        playSound();
        playVibration();
        setState(() {
          isLevelSelected = true;
        });

        Future.delayed(Duration(seconds: 3), () async {
          MinesweeperMatrix minesweeperMatrix = new MinesweeperMatrix(
            gameLevel: gameLevel, screenSize: screenSize
          );
          setGameStatistics(updatedStats: {
            gameLevel == 1 ? 'easy_levels' : gameLevel == 2 ? 'medium_levels' : 'hard_levels' : 1
          });
          await Navigator.of(context).pushNamed('/startGame', arguments: minesweeperMatrix);
          setState(() {
            isLevelSelected = false;
          });
        });

      },
      child: SizedBox(
        width: screenSize.width * 0.75,
        child: Text(buttonLabel,
          textAlign: TextAlign.center,
          style: getTextStyleSettings(fontSize: FontSize.LARGE),
        ),
      )
    );
  }
}

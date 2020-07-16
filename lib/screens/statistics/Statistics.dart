import 'package:Minesweeper/services/gameStatistics.dart';
import 'package:Minesweeper/utils/appConstants.dart';
import 'package:Minesweeper/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Statistics extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

class _StatisticsState extends State<Statistics> {

  Map<String, int> gameStatistics;
  List<Widget> _statisticsDetails = List();

  @override
  void didChangeDependencies() {
    getGameStatistics().then((value) {
      setState(() {
        gameStatistics = value;
        _statisticsDetails.insertAll(0,
          gameStatistics['total_time_played'] > 0
            ? getGameStatisticsContainer() : getNoGamesPlayedContainer()
        );
      });
    });
    super.didChangeDependencies();
  }

  List<Widget> getGameStatisticsContainer() {
    return <Widget>[
      getWinsAndTimePlayedDetails(),
      SizedBox(height: 20),
      getOtherStatTextWidget('Wins', gameStatistics['wins']),
      getOtherStatTextWidget('Loses', gameStatistics['loses']),
      getOtherStatTextWidget('Squares Popped', gameStatistics['squares_popped']),
      getOtherStatTextWidget('Bombs Diffused', gameStatistics['diffused_bombs']),
      getOtherStatTextWidget('Beginner Levels', gameStatistics['easy_levels']),
      getOtherStatTextWidget('Intermediate Levels', gameStatistics['medium_levels']),
      getOtherStatTextWidget('Advanced Levels', gameStatistics['hard_levels']),
    ];
  }

  Widget getOtherStatTextWidget(String keyName, int keyValue) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text('$keyName:$keyValue', style: getTextStyleSettings()),
    );
  }

  List<Widget> getNoGamesPlayedContainer() {
    return <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Image.asset(
            getImageFilePath(ImageType.SAD_EMOJI), width: 200, alignment: Alignment.center
          ),
        ],
      ),
      new SizedBox(height: 10),
      new Text(NO_GAME_PLAYED_MESSAGE,
        style: getTextStyleSettings(),
        textAlign: TextAlign.justify),
      getWinsAndTimePlayedDetails()
    ];
  }

  getWinsAndTimePlayedDetails() {
    return Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Image.asset(getImageFilePath(ImageType.TROPHY_ICON)),
              new Text(
                gameStatistics['wins'] > 0 ? '${gameStatistics['wins']}' : '---',
                style: getTextStyleSettings())
            ],
          ),
          new Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              new Image.asset(getImageFilePath(ImageType.CLOCK_ICON)),
              new Text(
                getDurationString(seconds: gameStatistics['total_time_played']),
                style: getTextStyleSettings())
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(title: 'Game Statistics'),
      backgroundColor: WHITE_COLOR,
      body: Container(
        color: WHITE_COLOR,
        padding: EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: _statisticsDetails,
        ),
      ),
    );
  }

}

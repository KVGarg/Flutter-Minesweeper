import 'package:Minesweeper/utils/appConstants.dart';
import 'package:Minesweeper/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  static BuildContext activityContext;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(buildContext: activityContext),
      child: Scaffold(
        body: Builder(builder: (BuildContext buildContext) {
          activityContext = buildContext;
          return Container(
            color: WHITE_COLOR,
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                new Image.asset('assets/images/App-Logo.png'),
                SizedBox(height: 10),
                new Text('Minesweeper Board Game', style: TextStyle(
                  fontFamily: 'PressStart2P',
                  decoration: TextDecoration.none,
                  fontSize: FontSize.MEDIUM
                )),
                SizedBox(height: 30),
                FlatButton.icon(
                  onPressed: () => Navigator.of(context).pushNamed('/chooseGameLevel'),
                  icon: Icon(Icons.play_arrow),
                  label: Text('Play Game      '),
                ),
                FlatButton.icon(
                  onPressed: () => Navigator.of(context).pushNamed('/instructions'),
                  icon: Icon(Icons.info),
                  label: Text('Instructions   ', textAlign: TextAlign.left),
                ),
                FlatButton.icon(
                  onPressed: () => Navigator.of(context).pushNamed('/statistics'),
                  icon: Icon(Icons.list),
                  label: Text('Statistics     ', textAlign: TextAlign.left),
                ),
                FlatButton.icon(
                  onPressed: () => Navigator.of(context).pushNamed('/aboutDeveloper'),
                  icon: Icon(Icons.person),
                  label: Text('About Developer', textAlign: TextAlign.left),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

}

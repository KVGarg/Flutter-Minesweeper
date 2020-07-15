import 'package:Minesweeper/utils/appConstants.dart';
import 'package:Minesweeper/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {

  static BuildContext activityContext;
  static Size screenSize;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
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
                getMenuOption(
                  onPressed: () => Navigator.of(context).pushNamed('/chooseGameLevel'),
                  optionIcon: Icons.play_arrow,
                  label: 'Play Game',
                  context: context
                ),
                getMenuOption(
                  onPressed: () => Navigator.of(context).pushNamed('/instructions'),
                  optionIcon: Icons.info,
                  label: 'Instructions',
                  context: context
                ),
                getMenuOption(
                  onPressed: () => Navigator.of(context).pushNamed('/statistics'),
                  optionIcon: Icons.list,
                  label: 'Statistics',
                  context: context
                ),
                getMenuOption(
                  onPressed: () => Navigator.of(context).pushNamed('/aboutDeveloper'),
                  optionIcon: Icons.person,
                  label: 'About Developer',
                  context: context
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
  
  Widget getMenuOption({
    @required onPressed, @required IconData optionIcon, @required String label,
    @required BuildContext context
  }){

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        FlatButton.icon(
          padding: EdgeInsets.only(left: screenSize.width * 0.20),
          onPressed: onPressed,
          icon: Icon(optionIcon),
          label: Text(label, textAlign: TextAlign.left),
        ),
      ],
    );
  }
}

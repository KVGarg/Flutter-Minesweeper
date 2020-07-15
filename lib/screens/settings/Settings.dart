import 'package:Minesweeper/utils/appConstants.dart';
import 'package:Minesweeper/utils/functions.dart';
import 'package:Minesweeper/services/manageSoundAndVibrations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  Size screenSize;

  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: getAppBar(title: 'Settings'),
      backgroundColor: WHITE_COLOR,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            getSettingsOption(
              onPressed: () {
                setState(() {
                  toggleAppSounds();
                });
              },
              rowItems: <Widget>[
                Text('Sounds', style: getTextStyleSettings(fontSize: FontSize.LARGE)),
                Icon(playSounds ? Icons.volume_up : Icons.volume_off, size: IconSize.LARGE,),
              ]
            ),
            SizedBox(height: 10,),
            getSettingsOption(
              onPressed: () {
                setState(() {
                  toggleAppVibrations();
                });
              },
              rowItems: <Widget>[
                Text('Vibrations', style: getTextStyleSettings(fontSize: FontSize.LARGE)),
                Icon(playVibrations ? Icons.vibration : Icons.phone_iphone, size: IconSize.LARGE,),
              ]
            ),
          ],
        ),
      ),
    );
  }

  getSettingsOption({@required VoidCallback onPressed, @required List<Widget> rowItems}) {
    return FlatButton(
      padding: EdgeInsets.all(24.0),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: BLACK_87_COLOR),
        borderRadius: BorderRadius.circular(12.0)
      ),
      onPressed: onPressed,
      child: SizedBox(
        width: screenSize.width * 0.75,
        child: new Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: rowItems,
        ),
      )
    );
  }
}

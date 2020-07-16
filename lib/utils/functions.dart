import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:share/share.dart';

import 'appConstants.dart';

DateTime currentBackPressTime;

Future<bool> onWillPop({@required BuildContext buildContext}) {
  DateTime now = DateTime.now();
  if (currentBackPressTime == null ||
    now.difference(currentBackPressTime) > Duration(seconds: 2)) {
    currentBackPressTime = now;
    displaySnackBar(buildContext: buildContext, message: 'Double tap back to exit app');
    return Future.value(false);
  }
  exit(0);
  return Future.value(true);
}

void displaySnackBar({
  @required BuildContext buildContext, @required String message, backgroundColor: GREY_COLOR
}) {
  Scaffold.of(buildContext).showSnackBar(SnackBar(
    content: Text(message),
    duration: Duration(seconds: 2),
    backgroundColor: backgroundColor,
    action: SnackBarAction(label: "Dismiss", textColor: WHITE_COLOR,
      onPressed: () {
        Scaffold.of(buildContext).hideCurrentSnackBar();
      }),
  ));
}

Widget getAppBar({@required String title}) {
  return AppBar(
    title: Text(title, style: getTextStyleSettings(),),
    backgroundColor: WHITE_COLOR,
    leading: new Image.asset('assets/images/app_logo.png'),
    elevation: 0.0,
    actions: <Widget>[
      IconButton(
        icon: Icon(Icons.share),
        onPressed: shareApp)
    ],
  );
}

Widget getAnimatedLoader({bool isFormSubmitted = true}) {
  return Visibility(
    visible: isFormSubmitted,
    maintainState: true,
    maintainAnimation: true,
    maintainSize: true,
    child: Stack(
      children: <Widget>[
        Positioned.fill(
          child: Opacity(opacity: 0.5,
            child: Container(color: WHITE_70_COLOR))),
        Positioned.fill(
          child: Center(
            child: SpinKitCircle(
              color: ACCENT_COLOR,
              size: 50.0,
            ),
          ))
      ],
    ));
}

TextStyle getTextStyleSettings({
  String fontFamily: 'PressStart2P', double fontSize: FontSize.MEDIUM,
  Color fontColor: BLACK_87_COLOR
}) {
  return TextStyle(
    color: fontColor,
    height: 1.5,
    fontFamily: fontFamily,
    textBaseline: TextBaseline.ideographic,
    decoration: TextDecoration.none,
    fontSize: fontSize);
}

String getDurationString({@required int seconds}) {
  Duration playedTimeDuration = new Duration(seconds: seconds);

  if (playedTimeDuration.inDays > 0)
    return '${playedTimeDuration.inDays} Day(s)';
  else if (playedTimeDuration.inHours > 0)
    return '${playedTimeDuration.inHours} Hour(s)';
  else if (playedTimeDuration.inMinutes > 0)
    return '${playedTimeDuration.inMinutes} Minute(s)';
  else if (playedTimeDuration.inSeconds > 0)
    return '${playedTimeDuration.inSeconds} Second(s)';
  else
    return '---';

}

void shareApp() {
  Share.share('Download and Install this cool board game.\nDownload Link:'
    ' ${SocialMediaLinks.APP_DOWNLOAD_LINK}', subject: 'Minesweeper Board Game'
  );
}
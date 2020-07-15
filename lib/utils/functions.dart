import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  String fontFamily: 'PressStart2P', double fontSize: FontSize.MEDIUM
}) {
  return TextStyle(
    color: BLACK_87_COLOR,
    height: 1.5,
    fontFamily: fontFamily,
    textBaseline: TextBaseline.ideographic,
    decoration: TextDecoration.none,
    fontSize: fontSize);
}

Widget getBackButton({@required BuildContext buildContext}) {
  return Visibility(
    visible: Platform.isIOS,
    child: FlatButton.icon(
      shape: Border.all(color: BLACK_COLOR, width: 1.0, style: BorderStyle.solid),
      onPressed: () => Navigator.of(buildContext).pop(),
      icon: Icon(Icons.arrow_back_ios),
      label: Text('Go Back',
        style: getTextStyleSettings(fontFamily: 'PressStart2P')
      )));
}
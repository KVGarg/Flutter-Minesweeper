import 'package:Minesweeper/screens/Home.dart';
import 'package:Minesweeper/screens/about_me/AboutMe.dart';
import 'package:Minesweeper/screens/instructions/Instructions.dart';
import 'package:Minesweeper/screens/play_game/ChooseGameLevel.dart';
import 'package:Minesweeper/screens/play_game/StartGame.dart';
import 'package:Minesweeper/screens/settings/Settings.dart';
import 'package:Minesweeper/screens/statistics/Statistics.dart';
import 'package:Minesweeper/services/gameStatistics.dart';
import 'package:Minesweeper/services/manageSoundAndVibrations.dart';
import 'package:Minesweeper/utils/appConstants.dart';
import 'package:Minesweeper/utils/functions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {

  WidgetsFlutterBinding.ensureInitialized();
  // Allow only Portrait Orientation
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // Hide Top, and Bottom Bar
  SystemChrome.setEnabledSystemUIOverlays ([]);
  // Init Game Statistics, and app setings in local storage
  initGameStatistics();
  initSoundAndVibrationsSettings();

  runApp(
    MaterialApp(
      title: 'Minesweeper Board Game',
      theme: ThemeData(
        primaryColor: PRIMARY_COLOR,
        accentColor: ACCENT_COLOR,
        brightness: Brightness.light,
        fontFamily: 'PressStart2P',
        pageTransitionsTheme: PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          }
        ) // used for swipe-back gestures
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: getApplicationRoutes(),
    )
  );
}

Map<String, Widget Function(BuildContext)> getApplicationRoutes() {
  return {
    '/': (BuildContext buildContext) => MyApp(),
    '/home': (BuildContext buildContext) => HomeScreen(),
    '/chooseGameLevel': (BuildContext buildContext) => ChooseGameLevel(),
    '/startGame': (BuildContext buildContext) => StartGame(),
    '/instructions': (BuildContext buildContext) => Instructions(),
    '/statistics': (BuildContext buildContext) => Statistics(),
    '/settings': (BuildContext buildContext) => Settings(),
    '/aboutDeveloper': (BuildContext buildContext) => AboutMe(),
  };
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: '/home',
      title: new Text('Minesweeper Board Game'),
      image: new Image.asset(getImageFilePath(ImageType.APP_LOGO)),
      backgroundColor: WHITE_COLOR,
      photoSize: 100.0,
      loaderColor: ACCENT_COLOR
    );
  }

}

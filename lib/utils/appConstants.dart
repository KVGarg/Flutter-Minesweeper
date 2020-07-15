import 'package:flutter/material.dart';

// COLORS //
const Color PRIMARY_COLOR = Colors.amber;
const Color ACCENT_COLOR = Colors.yellow;
const Color WHITE_70_COLOR = Colors.white70;
const Color BLACK_87_COLOR = Colors.black87;
const Color BLACK_COLOR = Colors.black;
const Color WHITE_COLOR = Colors.white;
const Color GREY_COLOR = Colors.grey;
const Color BLUE_GREY_COLOR = Colors.blueGrey;
const Color GREEN_COLOR = Colors.green;
const Color LIGHT_GREEN_COLOR = Colors.lightGreen;
const Color RED_COLOR = Colors.red;
const Color RED_ACCENT_COLOR = Colors.redAccent;
const Color TRANSPARENT_COLOR = Colors.transparent;

// ICON SIZES
class IconSize {
  static const LARGE = 30.0;
  static const MEDIUM = 26.0;
  static const SMALL = 22.0;
}

// FONT SIZES
class FontSize {
  static const LARGE = 15.0;
  static const MEDIUM = 13.0;
  static const SMALL = 11.0;
}

// SOCIAL MEDIA LINKS
const LINKEDIN_PROFILE = 'https://www.linkedin.com/in/keshav-g-88239b92/';
const GITHUB_PROFILE = 'https://github.com/KVGarg/';
const GITLAB_PROFILE = 'https://gitlab.com/KVGarg/';
const PERSONAL_WEBSITE = 'https://kvgarg.github.io/';

// ABOUT DEVELOPER
const NAME = 'Keshav Garg';
const ABOUT_DEVELOPER = "Good to know that you're interested in knowing about the developer. "
  "This app is developed by Keshav Garg, 22 years old from chandigarh. His hometown is located"
  " near the foothills of the Sivalik Range of the Himalayas in northwest India.\n"
  "He is a software engineer by profession, getting graduated this year (most probably by "
  "August 2020). He is known by commitments made to his work, and the team. During his career, "
  "he has developed skills like being a productive software developer, developing customer "
  "centered mobile application, and websites, and apart from all this he is UI/UX designer "
  "also.";

// GAME INSTRUCTIONS
const GAME_INSTRUCTIONS = [
  'To uncover a square, click on one of the squares on the grid.',
  'By clicking on a square, you can see the number of mines in the neighbouring boxes (maximum 8) '
  'that surround it to the left or right, up or down, or diagonally. Be careful, some squares hide '
  'a bomb and other squares do not.',
  'Use the numbers to free up other boxes. For example, the "2" on a square represent that the '
  'square is surrounded by 2 mines which can be anywhere left or right, up or down, or diagonally.',
  'Long press on a square to place a flag! It potentially (or surely) hides a bomb, you can guess '
  'that there are no mines in the marked places.',
  'There are 3 game levels-\n'
    '* Beginner (9 * 9 Board and 10 Mines)\n'
    '* Intermediate (16 * 16 Board and 40 Mines)\n'
    '* Advanced (24 * 24 Board and 99 Mines)'
];

// ERROR MESSAGES
const UNEXPECTED_ERROR_MESSAGE = 'An unexpected error raised, Please try again, or contact support '
  'team.';
const NO_GAME_PLAYED_MESSAGE = 'Hey there! Looks like you have not played any game. Who is '
  'stopping you from playing this cool game, an all-time favourite game from childhood. Hurry Up! '
  'Go Back,  and play a game.';

// APP DOWNLOAD Link
const GOOGLE_DRIVE_LINK = 'https://flutter.dev';

// SOUND FILE PATHS
const BLIP_SOUND_FP = 'assets/sounds/blip.wav';
const DIGGING_SOUND_FP = 'assets/sounds/digging.wav';
const EXPLOSION_SOUND_FP = 'assets/sounds/explosion.mp3';

// Game Matrices Init Classes
class GameLevels {
  static int beginner = 1;
  static int intermediate = 2;
  static int advanced = 3;
}

class LevelSize {
  static int beginner = 9;
  static int intermediate = 16;
  static int advanced = 24;
}

class LevelMines {
  static int beginner = 10;
  static int intermediate = 40;
  static int advanced = 99;
}

class NeighbourDensityBasedColor {
  static Color one = Colors.greenAccent;
  static Color two = Colors.green;
  static Color three = Colors.redAccent;
  static Color four = Colors.red;
  static Color five = Colors.deepPurpleAccent;
  static Color six = Colors.deepPurple;
  static Color seven = Colors.purpleAccent;
  static Color eight = Colors.purple;
}
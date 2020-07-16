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
class SocialMediaLinks {
  static const LINKEDIN_PROFILE = 'https://www.linkedin.com/in/keshav-g-88239b92/';
  static const GITHUB_PROFILE = 'https://github.com/KVGarg/';
  static const GITLAB_PROFILE = 'https://gitlab.com/KVGarg/';
  static const PERSONAL_WEBSITE = 'https://kvgarg.github.io/';
  static const APP_DOWNLOAD_LINK = 'https://flutter.dev';
}

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

// SOUND FILE PATHS
class GameSounds {
  static const DIGGING_SOUND_FP = 'digging.wav';
  static const BLIP_SOUND_FP = 'blip.wav';
  static const EXPLOSION_SOUND_FP = 'explosion.mp3';
  static const WIN_SOUND_FP = 'win_sound.wav';
}

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
  static Color one = Colors.green.shade900;
  static Color two = Colors.amber.shade700;
  static Color three = Colors.redAccent;
  static Color four = Colors.red;
  static Color five = Colors.deepPurpleAccent;
  static Color six = Colors.deepPurple;
  static Color seven = Colors.purpleAccent;
  static Color eight = Colors.purple;

  Color getColorFromIndex({int index}) {
    Color color;
    switch (index) {
      case 1: color = one; break;
      case 2: color = two; break;
      case 3: color = three; break;
      case 4: color = four; break;
      case 5: color = five; break;
      case 6: color = six; break;
      case 7: color = seven; break;
      case 8: color = eight; break;
    }
    return color;
  }

}

class ImageType {
  static const APP_LOGO = 'app_logo.png';
  static const CLOCK_ICON = 'clock_icon.png';
  static const DARK_GRASS = 'dark_grass.png';
  static const FLAG_ICON = 'flag_icon.png';
  static const DEVELOPER = 'keshav_garg.jpeg';
  static const LIGHT_GRASS = 'light_grass.png';
  static const LOSE_SCREEN = 'lose_screen.png';
  static const SAD_EMOJI = 'sad_emoji.png';
  static const SHOVEL_ICON = 'shovel_icon.png';
  static const TROPHY_ICON = 'trophy_icon.png';
  static const WIN_SCREEN = 'win_Screen.png';
}

class GameMessages {
  static const WIN = 'Congratulations! You have cleared all the land, by not stepping on any mine.'
    ' Wanna try again one more time?';
  static const LOSE = 'Accidentally! You stepped on a mine. No Worries, Wins and Loses are a part'
    ' of game. Try again one more time.';
}
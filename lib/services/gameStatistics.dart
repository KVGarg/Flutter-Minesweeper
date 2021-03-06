import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// Init the game statistics, to keep records of each lose/win of the user
void initGameStatistics() async {
  String gameStats = await FlutterSecureStorage().read(key: 'statistics');
  if (gameStats == null)
    FlutterSecureStorage().write(
      key: 'statistics',
      value: jsonEncode(<String, int>{
        'wins': 0,
        'loses': 0,
        'total_time_played': 0,
        'squares_popped': 0,
        'diffused_bombs': 0,
        'easy_levels': 0,
        'medium_levels': 0,
        'hard_levels': 0,
      })
    );
}

// Get the user game plays statistics
Future<Map<String, int>> getGameStatistics() async {
  String gameStats = await FlutterSecureStorage().read(key: 'statistics');
  return Map<String, int>.from(jsonDecode(gameStats));
}

// Set the user game play statistics for the selected values
void setGameStatistics({@required Map<String, int> updatedStats}) async {
  Map<String, int> gameStats = await getGameStatistics();
  updatedStats.forEach((key, value) {
    gameStats[key] += value;
  });
  FlutterSecureStorage().write(key: 'statistics', value: jsonEncode(gameStats));
}
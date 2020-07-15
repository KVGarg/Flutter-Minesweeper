import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void initGameStatistics() async {
  String gameStats = await FlutterSecureStorage().read(key: 'statistics');
  if (gameStats == null)
    FlutterSecureStorage().write(
      key: 'statistics',
      value: jsonEncode(<String, int>{
        'wins': 12,
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

Future<Map<String, int>> getGameStatistics() async {
  String gameStats = await FlutterSecureStorage().read(key: 'statistics');
  return Map<String, int>.from(jsonDecode(gameStats));
}

void setGameStatistics({@required String keyName, @required int keyValue}) async {
  String gameStatsString = await FlutterSecureStorage().read(key: 'statistics');
  Map<String, int> gameStats = jsonDecode(gameStatsString);
  gameStats[keyName] = keyValue;
  FlutterSecureStorage().write(key: 'statistics', value: jsonEncode(gameStats));
}
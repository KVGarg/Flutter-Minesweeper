import 'package:Minesweeper/utils/appConstants.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vibration/vibration.dart';

final assetsAudioPlayer = AssetsAudioPlayer();
bool playSounds = true;
bool playVibrations = true;

Future<void> initSoundAndVibrationsSettings() async {
  String playSoundsAsStr = await FlutterSecureStorage().read(key: 'ENABLE_SOUNDS');
  if (playSoundsAsStr == null) {
    playSoundsAsStr = 'true';
    FlutterSecureStorage().write(key: 'ENABLE_SOUNDS', value: playSoundsAsStr);
  }

  String playVibrationsAsStr = await FlutterSecureStorage().read(key: 'ENABLE_VIBRATIONS');
  if (playVibrationsAsStr == null) {
    playVibrationsAsStr = 'true';
    FlutterSecureStorage().write(key: 'ENABLE_VIBRATIONS', value: playVibrationsAsStr);
  }

  playSounds = playSoundsAsStr == 'true';
  playVibrations = playVibrationsAsStr == 'true';
}

void toggleAppSounds() async {
  playSounds = !playSounds;
  if (playSounds)
    playSound();
  await FlutterSecureStorage().write(key: 'ENABLE_SOUNDS', value: playSounds.toString());
}

void toggleAppVibrations() async {
  playVibrations = !playVibrations;
  if (playVibrations)
    playVibration();
  await FlutterSecureStorage().write(key: 'ENABLE_VIBRATIONS', value: playVibrations.toString());
}

void playSound({String fileName: GameSounds.BLIP_SOUND_FP}) {
  assetsAudioPlayer.stop();
  if (playSounds)
    assetsAudioPlayer.open(Audio('assets/sounds/$fileName'));
}

Future<void> playVibration() async {
  if (playVibrations && await Vibration.hasVibrator())
    Vibration.vibrate(duration: 300, amplitude: 64);
}

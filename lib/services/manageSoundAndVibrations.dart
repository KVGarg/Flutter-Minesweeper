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
    playButtonClickSound();
  await FlutterSecureStorage().write(key: 'ENABLE_SOUNDS', value: playSounds.toString());
}

void toggleAppVibrations() async {
  playVibrations = !playVibrations;
  if (playVibrations)
    playVibration();
  await FlutterSecureStorage().write(key: 'ENABLE_VIBRATIONS', value: playVibrations.toString());
}

void playButtonClickSound() {
  assetsAudioPlayer.stop();
  if (playSounds)
    assetsAudioPlayer.open(Audio(BLIP_SOUND_FP));
}

void playExplosionSound() {
  assetsAudioPlayer.stop();
  if (playSounds)
    assetsAudioPlayer.open(Audio(EXPLOSION_SOUND_FP));
}

void playShovelDigSound() {
  assetsAudioPlayer.stop();
  if (playSounds)
    assetsAudioPlayer.open(Audio(DIGGING_SOUND_FP));
}

Future<void> playVibration() async {
  if (playVibrations && await Vibration.hasVibrator())
    Vibration.vibrate(duration: 300, amplitude: 64);
}

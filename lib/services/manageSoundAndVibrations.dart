import 'package:Minesweeper/utils/appConstants.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:vibration/vibration.dart';

final assetsAudioPlayer = AssetsAudioPlayer();
bool playSounds = true;
bool playVibrations = true;

// Init the app settings related to sound, and vibrations. These settings are being used all-over
// the app while a user selcts any option/taps on a button.
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

// Toggle the sound settings
void toggleAppSounds() async {
  playSounds = !playSounds;
  if (playSounds)
    playSound();
  await FlutterSecureStorage().write(key: 'ENABLE_SOUNDS', value: playSounds.toString());
}

// Toggle the app vibration settings
void toggleAppVibrations() async {
  playVibrations = !playVibrations;
  if (playVibrations)
    playVibration();
  await FlutterSecureStorage().write(key: 'ENABLE_VIBRATIONS', value: playVibrations.toString());
}

// Play a selected sound, when user taps on a button
void playSound({String fileName: GameSounds.BLIP_SOUND_FP}) {
  assetsAudioPlayer.stop();
  if (playSounds)
    assetsAudioPlayer.open(Audio('assets/sounds/$fileName'));
}

// Play a small amplitude vibration while playing a sound
Future<void> playVibration() async {
  if (playVibrations && await Vibration.hasVibrator())
    Vibration.vibrate(duration: 300, amplitude: 64);
}

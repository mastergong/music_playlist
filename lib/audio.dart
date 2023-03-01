import 'package:audio_manager/audio_manager.dart';

class AudioControl {
  static final AudioManager control = AudioManager.instance;
  static bool isPlaying = false;
  static PlayMode playMode = control.playMode;
  static Duration duration = const Duration(microseconds: 0);
  static Duration position = const Duration(microseconds: 0);

  static double slider = 0;
  static double sliderVolume = 0;

  static List<AudioInfo> songList = [];
}

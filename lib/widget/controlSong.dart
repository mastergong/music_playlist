import 'package:audio_manager/audio_manager.dart';
import 'package:flutter/material.dart';
import '../audio.dart';
import 'songprogress.dart';

Widget cntrolPanel({Function()? onPressednextMode}) {
  return Column(children: [
    Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
              icon: getPlayModeIcon(AudioControl.playMode),
              onPressed: onPressednextMode),
          IconButton(
              iconSize: 36,
              icon: const Icon(
                Icons.skip_previous,
                color: Colors.black,
              ),
              onPressed: () {
                AudioControl.control.previous();
              }),
          IconButton(
            onPressed: () async {
              bool playing = await AudioControl.control.playOrPause();
              debugPrint("await -- $playing");
            },
            padding: const EdgeInsets.all(0.0),
            icon: Icon(
              AudioControl.isPlaying ? Icons.pause : Icons.play_arrow,
              size: 48.0,
              color: Colors.black,
            ),
          ),
          IconButton(
              iconSize: 36,
              icon: const Icon(
                Icons.skip_next,
                color: Colors.black,
              ),
              onPressed: () {
                AudioControl.control.next();
              }),
          IconButton(
              icon: const Icon(
                Icons.stop,
                color: Colors.black,
              ),
              onPressed: () => AudioControl.control.stop()),
        ],
      ),
    ),
  ]);
}

Widget getPlayModeIcon(PlayMode playMode) {
  switch (playMode) {
    case PlayMode.sequence:
      return const Icon(
        Icons.repeat,
        color: Colors.black,
      );
    case PlayMode.shuffle:
      return const Icon(
        Icons.shuffle,
        color: Colors.black,
      );
    case PlayMode.single:
      return const Icon(
        Icons.repeat_one,
        color: Colors.black,
      );
  }
}

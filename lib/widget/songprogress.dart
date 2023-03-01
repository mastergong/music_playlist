import 'dart:ffi';

import 'package:flutter/material.dart';

import '../audio.dart';

String _formatDuration(Duration d) {
  if (d == null) return "--:--";
  int minute = d.inMinutes;
  int second = (d.inSeconds > 60) ? (d.inSeconds % 60) : d.inSeconds;
  String format =
      "${(minute < 10) ? "0$minute" : "$minute"}:${(second < 10) ? "0$second" : "$second"}";
  return format;
}

Widget songProgress(
    {required BuildContext context, Function(double)? onChanged}) {
  var sliderstyle = const TextStyle(color: Colors.black);

  return Container(
    child: Row(
      children: <Widget>[
        Text(
          _formatDuration(AudioControl.position),
          style: sliderstyle,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: SliderTheme(
              data: SliderTheme.of(context).copyWith(
                trackHeight: 2,
                thumbColor: Colors.blueAccent,
                overlayColor: Colors.blue,
                thumbShape: const RoundSliderThumbShape(
                  disabledThumbRadius: 5,
                  enabledThumbRadius: 5,
                ),
                overlayShape: const RoundSliderOverlayShape(
                  overlayRadius: 10,
                ),
                activeTrackColor: Colors.blueAccent,
                inactiveTrackColor: Colors.grey,
              ),
              child: Slider(
                value: AudioControl.slider,
                onChanged: onChanged,
                onChangeEnd: (value) {
                  Duration msec = Duration(
                      milliseconds:
                          (AudioControl.duration.inMilliseconds * value)
                              .round());
                  AudioControl.control.seekTo(msec);
                },
              ),
            ),
          ),
        ),
        Text(
          _formatDuration(AudioControl.duration),
          style: sliderstyle,
        ),
      ],
    ),
  );
}

import 'package:flutter/material.dart';

import '../audio.dart';

Widget volumeFrame({Function(double)? onChanged}) {
  return Container(
    color: Colors.amber[50],
    child: Column(
      children: [
        const SizedBox(
          height: 10,
        ),
        Row(children: [
          IconButton(
              icon: const Icon(
                Icons.audiotrack,
                color: Colors.black,
              ),
              onPressed: () {
                AudioControl.control.setVolume(0);
              }),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Slider(
                value: AudioControl.sliderVolume,
                onChanged: onChanged,
              ),
            ),
          ),
        ]),
      ],
    ),
  );
}

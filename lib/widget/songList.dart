import 'package:flutter/material.dart';

import '../audio.dart';

Widget songListAll() {
  return Expanded(
    child: ListView.separated(
        itemBuilder: (context, index) {
          return ListTile(
            leading: (Uri.parse(AudioControl.control.audioList[index].coverUrl)
                    .isAbsolute)
                ? Image(
                    width: 50,
                    height: 50,
                    image: NetworkImage(
                        AudioControl.control.audioList[index].coverUrl))
                : Image(
                    width: 50,
                    height: 50,
                    image: AssetImage(
                        AudioControl.control.audioList[index].coverUrl)),
            title: Text(AudioControl.control.audioList[index].title,
                style: const TextStyle(fontSize: 18)),
            subtitle: Text(AudioControl.control.audioList[index].desc),
            trailing: const Icon(
              Icons.play_arrow,
              color: Colors.black,
            ),
            onTap: () => AudioControl.control.play(index: index),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
        itemCount: AudioControl.control.audioList.length),
  );
}

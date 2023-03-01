import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:audio_manager/audio_manager.dart';
import 'package:music_playlist/data/music.dart';
import 'package:path_provider/path_provider.dart';

import 'audio.dart';
import 'widget/controlSong.dart';
import 'widget/songList.dart';
import 'widget/songprogress.dart';
import 'widget/volume.dart';

void main() => runApp(MusicApp());

class MusicApp extends StatefulWidget {
  @override
  MusicAppState createState() => MusicAppState();
}

class MusicAppState extends State<MusicApp> {
  String _error = '';
  num curIndex = 0;

  @override
  void initState() {
    super.initState();
    loadFile();
    setupAudio();
  }

  @override
  void dispose() {
    AudioControl.control.release();
    super.dispose();
  }

  void setupAudio() {
    AudioControl.control.audioList = AudioControl.songList;
    AudioControl.control.intercepter = true;
    AudioControl.control.play(auto: false);

    AudioControl.control.onEvents((events, args) {
      debugPrint("$events, $args");
      switch (events) {
        case AudioManagerEvents.start:
          debugPrint(
              "start load data callback, curIndex is ${AudioControl.control.curIndex}");
          AudioControl.position = AudioControl.control.position;
          AudioControl.duration = AudioControl.control.duration;
          AudioControl.slider = 0;
          setState(() {});
          AudioControl.control.updateLrc("audio resource loading....");
          break;
        case AudioManagerEvents.ready:
          debugPrint("ready to play");
          _error = '';
          AudioControl.sliderVolume = AudioControl.control.volume;
          AudioControl.position = AudioControl.control.position;
          AudioControl.duration = AudioControl.control.duration;
          setState(() {});
          // if you need to seek times, must after AudioManagerEvents.ready event invoked
          AudioControl.control.seekTo(const Duration(seconds: 0));
          break;
        case AudioManagerEvents.seekComplete:
          AudioControl.position = AudioControl.control.position;
          AudioControl.slider = AudioControl.position.inMilliseconds /
              AudioControl.duration.inMilliseconds;
          setState(() {});
          debugPrint("seek event is completed. position is [$args]/ms");
          break;
        case AudioManagerEvents.buffering:
          debugPrint("buffering $args");
          break;
        case AudioManagerEvents.playstatus:
          AudioControl.isPlaying = AudioControl.control.isPlaying;
          setState(() {});
          break;
        case AudioManagerEvents.timeupdate:
          AudioControl.position = AudioControl.control.position;
          AudioControl.slider = AudioControl.position.inMilliseconds /
              AudioControl.duration.inMilliseconds;
          if (AudioControl.slider < 0 ||
              AudioControl.slider == double.infinity) {
            AudioControl.slider = 0;
          }
          setState(() {});
          AudioControl.control.updateLrc(args["position"].toString());
          break;
        case AudioManagerEvents.error:
          _error = args;
          setState(() {});
          break;
        case AudioManagerEvents.ended:
          AudioControl.control.next();
          break;
        case AudioManagerEvents.volumeChange:
          AudioControl.sliderVolume = AudioControl.control.volume;
          setState(() {});
          break;
        default:
          break;
      }
    });
  }

  void loadFile() async {
    // get from network
    var list = SongList.getSongNetwork();
    list.forEach((item) => AudioControl.songList.add(AudioInfo(item.songsUrl,
        title: item.id, desc: item.songs, coverUrl: item.imageUrl)));

    // get from assete
    var ls = SongList.getSongLocal();
    for (var element in ls) {
      final audioFile = await rootBundle.load(element.songsUrl);
      final audio = audioFile.buffer.asUint8List();

      final appDocDir = await getApplicationDocumentsDirectory();

      String filename = element.songsUrl.split("/").last;

      final file = File("${appDocDir.path}/$filename");
      file.writeAsBytesSync(audio);

      AudioInfo info = AudioInfo("file://${file.path}",
          title: element.id, desc: element.songs, coverUrl: element.imageUrl);

      AudioControl.control.audioList.add(info);
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0.0,
            title: const Text('Music playlist'),
          ),
          extendBodyBehindAppBar: true,
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.green,
                  Colors.orange,
                ],
              ),
            ),
            child: Center(
              child: Column(
                children: [
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 10),
                  //   child: volumeFrame(onChanged: (value) {
                  //     setState(() {
                  //       AudioControl.sliderVolume = value;
                  //       AudioControl.control.setVolume(value, showVolume: true);
                  //     });
                  //   }),
                  // ),
                  const SizedBox(
                    height: 50,
                  ),

                  Center(
                    child: Column(
                      children: [
                        (Uri.parse(AudioControl.control.info!.coverUrl)
                                .isAbsolute)
                            ? Image(
                                width: 50,
                                height: 50,
                                image: NetworkImage(
                                    AudioControl.control.info!.coverUrl))
                            : Image(
                                width: 50,
                                height: 50,
                                image: AssetImage(
                                    AudioControl.control.info!.coverUrl)),
                        Text(_error.isNotEmpty
                            ? _error
                            : " เพลง :${AudioControl.control.info!.title}"),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: songProgress(
                              context: context,
                              onChanged: (value) {
                                setState(() {
                                  AudioControl.slider = value;
                                });
                              }),
                        ),
                        cntrolPanel(onPressednextMode: () {
                          AudioControl.playMode =
                              AudioControl.control.nextMode();
                          setState(() {});
                        }),
                      ],
                    ),
                  ),
                  songListAll(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

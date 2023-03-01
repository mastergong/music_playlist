import '../model/playlist_model.dart';

class SongList {
  static String pathAudios = 'assets/audios';
  static String pathImages = 'assets/images';
  static List<Playlist> getSongLocal() {
    List<Playlist> list = [];
    list.add(Playlist(
      id: 'Country',
      songs: 'country',
      songsUrl: '$pathAudios/country.mp3',
      imageUrl: '$pathImages/country.jpg',
    ));
    list.add(Playlist(
      id: 'Electronic',
      songs: 'electronic',
      songsUrl: '$pathAudios/electronic.mp3',
      imageUrl: '$pathImages/aLIEz.jpg',
    ));

    list.add(Playlist(
      id: 'Hiphop',
      songs: 'hiphop',
      songsUrl: '$pathAudios/hiphop.mp3',
      imageUrl: '$pathImages/country.jpg',
    ));

    list.add(Playlist(
      id: 'Pop',
      songs: 'pop',
      songsUrl: '$pathAudios/pop.mp3',
      imageUrl: '$pathImages/aLIEz.jpg',
    ));

    list.add(Playlist(
      id: 'Horn',
      songs: 'horn',
      songsUrl: '$pathAudios/horn.mp3',
      imageUrl: '$pathImages/country.jpg',
    ));

    list.add(Playlist(
      id: 'Water',
      songs: 'water',
      songsUrl: '$pathAudios/water.mp3',
      imageUrl: '$pathImages/aLIEz.jpg',
    ));

    return list;
  }

  static List<Playlist> getSongNetwork() {
    List<Playlist> list = [];

    list.add(Playlist(
        id: 'network',
        songs: 'network',
        songsUrl: "https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.m4a",
        imageUrl:
            "https://npr.brightspotcdn.com/dims4/default/bd20934/2147483647/strip/true/crop/1920x1183+0+49/resize/880x542!/quality/90/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2Ff1%2F2a%2F862f94d3419f8adf47b8dee8ebb3%2Fnational-negro-opera-house-mary-cardwell-dawson-black-history-pittsburgh-homewood-restoration-12.JPG"));

    list.add(Playlist(
        id: 'network1',
        songs: 'network',
        songsUrl: "https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.m4a",
        imageUrl:
            "https://npr.brightspotcdn.com/dims4/default/bd20934/2147483647/strip/true/crop/1920x1183+0+49/resize/880x542!/quality/90/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2Ff1%2F2a%2F862f94d3419f8adf47b8dee8ebb3%2Fnational-negro-opera-house-mary-cardwell-dawson-black-history-pittsburgh-homewood-restoration-12.JPG"));

    list.add(Playlist(
        id: 'network2',
        songs: 'network',
        songsUrl: "https://dl.espressif.com/dl/audio/ff-16b-2c-44100hz.m4a",
        imageUrl:
            "https://npr.brightspotcdn.com/dims4/default/c881b88/2147483647/strip/true/crop/5000x3333+0+0/resize/1760x1174!/format/webp/quality/90/?url=http%3A%2F%2Fnpr-brightspot.s3.amazonaws.com%2Fce%2Ff7%2F52e5db894dfa86aef02216f20b00%2Fcommonwealth-court-spotlight-pa.jpeg"));

    return list;
  }
}

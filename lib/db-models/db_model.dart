

import 'package:hive_flutter/hive_flutter.dart';

part 'db_model.g.dart';

@HiveType(typeId: 0)
class songListModel extends HiveObject {
  @HiveField(0)
  final String displayName;
  

  @HiveField(1)
  final String artist;

  @HiveField(2)
  final String uri;
  @HiveField(3)
  String title;
  @HiveField(4)
  int songId;


  // Add more fields if necessary

  songListModel({
    required this.displayName,
    required this.artist,
    required this.uri,
    required this.title,
    required this.songId

  });
}



// // db_models/hive_models/music_song_hive.dart
// import 'package:hive/hive.dart';

// part 'music_song_hive.g.dart';

// @HiveType(typeId: 1)
// class MusicSongHive {
//   @HiveField(0)
//   int songId;
//   @HiveField(1)
//   String uri;
//   @HiveField(2)
//   String name;
//   @HiveField(3)
//   String artist;
//   @HiveField(4)
//   String album;
//   @HiveField(5)
//   bool isLike;

//   MusicSongHive({
//     required this.songId,
//     required this.uri,
//     required this.name,
//     required this.artist,
//     required this.album,
//     required this.isLike,
//   });
// }


import 'package:hive_flutter/hive_flutter.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:project_music/db-models/db_model.dart';

void addSongsToHive({required List<SongModel> s}) async{
  print('hellow');
  final songBox= await Hive.openBox<songListModel>('song_box');
  
  if(songBox.isEmpty){
      for(SongModel songs in s){
   songBox.add(songListModel(displayName: songs.displayName, artist: songs.artist.toString(), uri: songs.uri.toString(), title: songs.title,songId: songs.id));
  }
  }
  print('hellow ${songBox.length}');

}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

final audioPlayer=AudioPlayer();

class PlayScreen extends StatefulWidget {
   const PlayScreen({Key? key, required this.songModel}) : super(key: key);
final SongModel songModel;
// final AudioPlayer audioPlayer;
// final int songModelIndex;
  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  // final AudioPlayer audioPlayer =AudioPlayer();

Duration duration = const Duration();
Duration position = const Duration();
  bool _isPlaying = false;
  
  get uri => null;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    playSong();
  }

  void playSong(){
    try{
      audioPlayer
      .setAudioSource(AudioSource.uri(uri.parse(widget.songModel.uri)
      ),
      );
      audioPlayer.play();
      _isPlaying =true;
    }on Exception {
      log("cannot parse song");
    }
    audioPlayer.durationStream.listen((d)
     { 
      setState(() {
        duration = d!;
      });
     });
      audioPlayer.durationStream.listen((p)
     { 
      setState(() {
        position = p!;
      });
     });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
    body: SafeArea(
      child: Container(
     width: double.infinity,
     padding: const EdgeInsets.all(16.0),
     child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IconButton(
          onPressed: (){
            Navigator.pop(context);
          }, icon:const Icon(Icons.arrow_back_ios_new_rounded),
          ),
  const SizedBox(height: 20,),
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 100.0,
                  child: Icon(Icons.music_note,size: 800.0,),
                ),
         const SizedBox(height: 30.0,),
         Text(widget.songModel.displayNameWOExt,
        overflow: TextOverflow.fade,maxLines:1,style:const TextStyle(fontWeight: FontWeight.bold,fontSize:30.0),
        ),
     const SizedBox(height: 10,),
            Text(
              widget.songModel.artist.toString() =='<unknown>'? "unknown artist":widget.songModel.artist.toString(),
           overflow: TextOverflow.fade,maxLines:1,style:const TextStyle(fontSize:20.0),
           ),
      const SizedBox(height: 10.0,),    
      Row(
        children: [
           Text(position.toString().split(".")[0]),
          Expanded(
            child: Slider(
            min: const Duration(microseconds: 0).inSeconds.toDouble(),
              value: position.inSeconds.toDouble(),
              max: duration.inSeconds.toDouble(),
               onChanged:(value){
              setState(() {
                changeToSeconds(value.toInt());
                value = value;
              });
            }),
            ),
             Text(duration.toString().split(".")[0])
        ],
      ), 
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.skip_previous, size: 40.0,),),
          IconButton(onPressed: (){
           setState(() {
            if (_isPlaying){
             audioPlayer.pause();
            }else{
            audioPlayer.play();
            }
              _isPlaying=!_isPlaying;
           });
          }, icon:  Icon(
           _isPlaying ? Icons.pause_circle: Icons.play_arrow,
             size: 40.0,),),
          IconButton(onPressed: (){}, icon: const Icon(Icons.skip_next, size: 40.0,),),
          
        ],
      ),
              ],
            ),
          ),
      ],
     ),
      ),
      ),
    );
  }

  void changeToSeconds(int seconds){
    Duration duration =Duration(seconds: seconds);
    audioPlayer.seek(duration);
  }
}
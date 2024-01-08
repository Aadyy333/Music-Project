import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project_music/db-models/song_db_functions.dart';
import 'package:project_music/screens/playscreen.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _audioquery = OnAudioQuery();

  // late Box<SongModel> songBox;
  

  @override
  void initState() {
    super.initState();
    //  requestPermission();
    // _audioquery = OnAudioQuery();
    // _audioplayer = AudioPlayer();

   
    
    checkPermission();
  }



  // void openBox() async {
  //   await Hive.initFlutter(); // Initialize Hive
  //   await Hive.openBox<SongModel>('songs'); // Open Hive box
  //   songBox = Hive.box<SongModel>('songs'); // Assign the box
  // }

  // void requestPermission() async {
  // final p=  await Permission.storage.request();
  // if(p.isGranted){
  //   fetchAndSaveSongs();
    
  // }
    
  // }

  // void playSong(String uri) {
  //   try {
  //     _audioplayer.setAudioSource(
  //       AudioSource.uri(
  //         Uri.parse(uri),
  //       ),
  //     );
  //     _audioplayer.play();
  //   } on Exception catch (e) {
  //     log("Error Parsing Song: $e");
  //   }
  // }

  Future<List<SongModel>> fetchAndSaveSongs() async {
    final List<SongModel> songs = await _audioquery.querySongs(
      sortType: null,
      orderType: OrderType.ASC_OR_SMALLER,
      uriType: UriType.EXTERNAL,
      ignoreCase: true,
    );

    addSongsToHive(s: songs);

    // if (songs.isNotEmpty) {
    //   // await songBox.clear();
    //   // await songBox.addAll(songs);

     
    // }
    return songs;
  }

    checkPermission() async {
    final per = await [Permission.audio, Permission.photos].request();

    if (per.values.every((status) => status == PermissionStatus.granted)) {
      fetchAndSaveSongs();
    } else {
      debugPrint("error in permission");
    }
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Studio'),
        centerTitle: true,
      ),
      body: FutureBuilder<List<SongModel>>(
     future: fetchAndSaveSongs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Text("No Songs found");
          } else {
            return ListView.builder(
              itemBuilder: (context, index) => ListTile(
                leading: QueryArtworkWidget(
                  id: snapshot.data![index].id,
                  type: ArtworkType.AUDIO,
                  nullArtworkWidget: const Icon(Icons.music_note),
                ),
                title: Text(snapshot.data![index].displayNameWOExt),
                subtitle: Text("${snapshot.data![index].artist}"),
                trailing: const Icon(Icons.more_horiz),
onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PlayScreen(
        songModel: snapshot.data![index],
        // audioPlayer: _audioplayer,
      ),
    ),
  );
},


              ),
              itemCount: snapshot.data!.length,
            );
          }
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.pink),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search, color: Colors.pink),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music, color: Colors.pink),
            label: 'Library',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings, color: Colors.pink),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

 


    // String? songUri = item.data![index].uri;
  // if (songUri != null) {
  //   playSong(songUri);
  // } else {
  //   log("Error: Invalid URI");
  // }


        // child: SafeArea(
        //     child: Column(
        //   children: [
        //     Expanded(
        //         child: PageView.builder(
        //             controller: _pageController,
        //             itemCount: _pages.length,
        //             onPageChanged: (index) {
        //               setState(() {
        //                 _currentIndex = index;
        //               });
        //             },
        //             itemBuilder: (context, index) {
        //               return _pages[index];
        //             })
        //             ),
        //   ],
        // )),
      
      // bottomNavigationBar: BottomNavigationBar(
      //     backgroundColor: const Color.fromARGB(255, 61, 20, 93),
      //     currentIndex: _currentIndex,
      //     onTap: (index) {
      //       setState(() {
      //         _currentIndex = index;
      //       });

      //       _pageController.jumpToPage(index);
      //     },
      //     // items: const [
          //   BottomNavigationBarItem(
          //       backgroundColor: Color.fromARGB(255, 61, 20, 93),
          //       icon: Icon(
          //         Icons.home,
          //         color: Colors.white,
          //       ),
          //       label: 'Home'),
          //   BottomNavigationBarItem(
          //       icon: Icon(
          //         Icons.search,
          //         color: Colors.white,
          //       ),
          //       label: 'Search'),
          //   BottomNavigationBarItem(
          //       icon: Icon(
          //         Icons.favorite,
          //         color: Colors.white,
          //       ),
          //       label: 'Favourite'),
          //   BottomNavigationBarItem(
          //       icon: Icon(
          //         Icons.playlist_play_rounded,
          //         color: Colors.white,
          //       ),
          //       label: 'Playlist'),
          // ]),


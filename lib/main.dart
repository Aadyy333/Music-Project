// main.dart
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/material.dart';
import 'package:project_music/db-models/db_model.dart';
// import 'package:provider/provider.dart';
import 'package:project_music/screens/splash_screen.dart';
// import 'package:project_music/provider/song_model_provider.dart';

void main() async {

await Hive.initFlutter(); 

  WidgetsFlutterBinding.ensureInitialized();

 
 Hive.registerAdapter(songListModelAdapter());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.pink),
        home: const SplashScreen(),
    );
  }
}

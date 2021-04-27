import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pankaj_5exception_machine_test/ui/add_album_screen.dart';
import 'package:pankaj_5exception_machine_test/ui/add_songs_screen.dart';
import 'package:pankaj_5exception_machine_test/ui/album_screen.dart';
import 'package:pankaj_5exception_machine_test/ui/songs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pankaj',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (route) {
        switch (route.name) {
          case "/":
            return CupertinoPageRoute(builder: (_) => AlbumScreen());
            break;

          case ALBUM_SCREEN:
            return CupertinoPageRoute(builder: (_) => AlbumScreen());
            break;

          case ADD_ALBUM_SCREEN:
            return CupertinoPageRoute(builder: (_) => AddAlbumScreen());
            break;

          case SONGS_SCREEN:
            return CupertinoPageRoute(
                builder: (_) => SongsScreen(
                      album: route.arguments,
                    ));
            break;
          case ADD_SONGS_SCREEN:
            return CupertinoPageRoute(
                builder: (_) => AddSongScreen(
                      album: route.arguments,
                    ));
            break;

          default:
            return CupertinoPageRoute(builder: (_) => AlbumScreen());
            break;
        }
      },
    );
  }
}

const ALBUM_SCREEN = "/album_screen";
const ADD_ALBUM_SCREEN = "/add_album_screen";
const SONGS_SCREEN = "/songs_screen";
const ADD_SONGS_SCREEN = "/add_songs_screen";

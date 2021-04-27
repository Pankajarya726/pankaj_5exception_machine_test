import 'package:flutter/material.dart';
import 'package:pankaj_5exception_machine_test/data/sqlite_db.dart';
import 'package:pankaj_5exception_machine_test/main.dart';
import 'package:pankaj_5exception_machine_test/model/Album.dart';
import 'package:pankaj_5exception_machine_test/model/song.dart';

class SongsScreen extends StatefulWidget {
  final Album album;

  SongsScreen({this.album});

  @override
  _SongsScreenState createState() => _SongsScreenState();
}

class _SongsScreenState extends State<SongsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.album.name}"),
        centerTitle: true,
        automaticallyImplyLeading: true,
        actions: [
          TextButton(
            onPressed: () async {
              var result = await Navigator.pushNamed(context, ADD_SONGS_SCREEN, arguments: widget.album);

              if (result != null) {
                setState(() {});
              }
            },
            child: Text(
              "Add",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      ),
      body: FutureBuilder<List<Song>>(
        future: DBProvider.db.getAllSongs(widget.album.id),
        builder: (BuildContext context, AsyncSnapshot<List<Song>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Song item = snapshot.data[index];
                return ListTile(
                  title: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.name),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

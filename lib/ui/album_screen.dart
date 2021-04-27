import 'package:flutter/material.dart';
import 'package:pankaj_5exception_machine_test/data/sqlite_db.dart';
import 'package:pankaj_5exception_machine_test/main.dart';
import 'package:pankaj_5exception_machine_test/model/Album.dart';

class AlbumScreen extends StatefulWidget {
  @override
  _AlbumScreenState createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Music Album"),
        centerTitle: true,
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () async {
              var result = await Navigator.pushNamed(context, ADD_ALBUM_SCREEN);
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
      body: FutureBuilder<List<Album>>(
        future: DBProvider.db.getAllAlbums(),
        builder: (BuildContext context, AsyncSnapshot<List<Album>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                Album item = snapshot.data[index];
                return ListTile(
                  title: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(item.name),
                      Text("₹" + item.price),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                  onTap: () => Navigator.pushNamed(context, SONGS_SCREEN, arguments: item),
                );
              },
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.delete),
        onPressed: () async {
          DBProvider.db.deleteAll();
          setState(() {});
        },
      ),
    );
  }
}

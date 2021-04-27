import 'package:flutter/material.dart';
import 'package:pankaj_5exception_machine_test/data/sqlite_db.dart';
import 'package:pankaj_5exception_machine_test/model/Album.dart';
import 'package:pankaj_5exception_machine_test/model/song.dart';

class AddSongScreen extends StatefulWidget {
  final Album album;

  AddSongScreen({this.album});

  @override
  _AddSongScreenState createState() => _AddSongScreenState();
}

class _AddSongScreenState extends State<AddSongScreen> {
  final edtName = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    edtName.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.album.name}"),
        centerTitle: true,
        automaticallyImplyLeading: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Container(
                  child: Text("Song title"),
                  width: width / 2 - 30,
                ),
                Container(
                  width: width / 2,
                  child: TextFormField(
                    controller: edtName,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                addSong(context);
              },
              color: Colors.blue,
              minWidth: width / 2,
              height: 40,
              child: Text(
                "Submit",
                style: TextStyle(color: Colors.white),
              ),
            )
          ],
        ),
      ),
    );
  }

  void addSong(BuildContext context) async {
    if (edtName.text.trim().isEmpty) {
      print("enter name");
    } else {
      print("album");
      Song song = Song(name: edtName.text.trim(), albumId: widget.album.id, id: 0);

      int i = await DBProvider.db.addSong(song);

      if (i > 0) {
        Navigator.of(context).pop(true);
      }
    }
  }
}

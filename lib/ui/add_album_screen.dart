import 'package:flutter/material.dart';
import 'package:pankaj_5exception_machine_test/data/sqlite_db.dart';
import 'package:pankaj_5exception_machine_test/model/Album.dart';

class AddAlbumScreen extends StatefulWidget {
  @override
  _AddAlbumScreenState createState() => _AddAlbumScreenState();
}

class _AddAlbumScreenState extends State<AddAlbumScreen> {
  final edtName = TextEditingController();
  final edtPrice = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    edtName.dispose();
    edtPrice.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text("Music Album"),
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
                  child: Text("Album name"),
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
            Row(
              children: [
                Container(
                  child: Text("Price"),
                  width: width / 2 - 30,
                ),
                Container(
                  width: width / 2,
                  child: TextFormField(
                    controller: edtPrice,
                    decoration: InputDecoration(border: OutlineInputBorder()),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 20,
            ),
            MaterialButton(
              onPressed: () {
                addAlbum(context);
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

  void addAlbum(BuildContext context) async {
    if (edtName.text.trim().isEmpty) {
      print("enter name");
    } else if (edtPrice.text.trim().isEmpty) {
      print("enter name");
    } else {
      print("album");
      Album album = Album(name: edtName.text.trim(), price: edtPrice.text.trim(), id: 0);

      int i = await DBProvider.db.addAlbum(album);

      if (i > 0) {
        Navigator.of(context).pop(true);
      }
    }
  }
}

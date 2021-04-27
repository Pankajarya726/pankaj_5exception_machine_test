import 'dart:async';
import 'dart:io';

import 'package:pankaj_5exception_machine_test/model/Album.dart';
import 'package:pankaj_5exception_machine_test/model/song.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBProvider {
  DBProvider._();

  static final DBProvider db = DBProvider._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {}, onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Album ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "price TEXT"
          ")");

      await db.execute("CREATE TABLE Song ("
          "id INTEGER PRIMARY KEY,"
          "name TEXT,"
          "albumId INTEGER"
          ")");
    });
  }

  Future<int> addAlbum(Album album) async {
    print("addAlbum");
    try {
      final db = await database;
      //get the biggest id in the table
      var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Album");
      int id = table.first["id"];
      //insert to the table using the new id
      var raw = await db.rawInsert(
          "INSERT Into Album (id,name,price)"
          " VALUES (?,?,?)",
          [id, album.name, album.price]);
      print(" album added --> $raw");
      return raw;
    } catch (e) {
      print("exception in add album --> ${e.message}");
      return 0;
    }
  }

  addSong(Song song) async {
    final db = await database;
    //get the biggest id in the table
    var table = await db.rawQuery("SELECT MAX(id)+1 as id FROM Song");
    int id = table.first["id"];
    //insert to the table using the new id
    var raw = await db.rawInsert(
        "INSERT Into Song (id,name,albumId)"
        " VALUES (?,?,?)",
        [id, song.name, song.albumId]);
    return raw;
  }

  getAlbum(int id) async {
    final db = await database;
    var res = await db.query("Album", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Album.fromMap(res.first) : null;
  }

  getSong(int id) async {
    final db = await database;
    var res = await db.query("Song", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? Song.fromMap(res.first) : null;
  }

  Future<List<Album>> getAllAlbums() async {
    final db = await database;
    var res = await db.query("Album");
    List<Album> list = res.isNotEmpty ? res.map((c) => Album.fromMap(c)).toList() : [];
    return list;
  }

  Future<List<Song>> getAllSongs(int albumId) async {
    final db = await database;
    var res = await db.query("Song", where: "albumId = ?", whereArgs: [albumId]);
    List<Song> list = res.isNotEmpty ? res.map((c) => Song.fromMap(c)).toList() : [];
    return list;
  }

  deleteAlbum(int id) async {
    final db = await database;
    return db.rawDelete("DELETE FROM Album WHERE id =? ", [id]);
    // return db.delete("Album", where: "id = ?", whereArgs: [id]);
  }

  deleteAll() async {
    final db = await database;
    db.delete("Album");
    db.delete("Song");
  }
}

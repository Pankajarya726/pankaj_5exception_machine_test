import 'dart:convert';

Song clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Song.fromMap(jsonData);
}

String clientToJson(Song data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Song {
  int id;
  String name;
  int albumId;

  Song({
    this.id,
    this.name,
    this.albumId,
  });

  factory Song.fromMap(Map<String, dynamic> json) => new Song(
        id: json["id"],
        name: json["name"],
        albumId: json["albumId"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "albumId": albumId,
      };
}

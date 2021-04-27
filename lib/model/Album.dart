import 'dart:convert';

Album clientFromJson(String str) {
  final jsonData = json.decode(str);
  return Album.fromMap(jsonData);
}

String clientToJson(Album data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Album {
  int id;
  String name;
  String price;

  Album({
    this.id,
    this.name,
    this.price,
  });

  factory Album.fromMap(Map<String, dynamic> json) => new Album(
        id: json["id"],
        name: json["name"],
        price: json["price"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "price": price,
      };
}

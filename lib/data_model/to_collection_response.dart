// To parse this JSON data, do
//
//     final topCollectionResponse = topCollectionResponseFromJson(jsonString);

import 'dart:convert';

TopCollectionResponse topCollectionResponseFromJson(String str) =>
    TopCollectionResponse.fromJson(json.decode(str));

String topCollectionResponseToJson(TopCollectionResponse data) =>
    json.encode(data.toJson());

class TopCollectionResponse {
  TopCollectionResponse({
    this.data,
    this.result,
    this.message,
  });

  List<Datum> data;
  bool result;
  String message;

  factory TopCollectionResponse.fromJson(Map<String, dynamic> json) =>
      TopCollectionResponse(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        result: json["result"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "result": result,
        "message": message,
      };
}

class Datum {
  Datum({
    this.id,
    this.name,
    this.iconOne,
    this.iconTwo,
    this.details,
    this.collectionCount,
  });

  int id;
  String name;
  String iconOne;
  String iconTwo;
  String details;
  int collectionCount;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        iconOne: json["icon_one"],
        iconTwo: json["icon_two"],
        details: json["details"],
        collectionCount: json["collection_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "icon_one": iconOne,
        "icon_two": iconTwo,
        "details": details,
        "collection_count": collectionCount,
      };
}

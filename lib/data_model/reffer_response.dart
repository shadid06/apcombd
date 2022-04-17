// To parse this JSON data, do
//
//     final refferResponse = refferResponseFromJson(jsonString);

import 'dart:convert';

RefferResponse refferResponseFromJson(String str) =>
    RefferResponse.fromJson(json.decode(str));

String refferResponseToJson(RefferResponse data) => json.encode(data.toJson());

class RefferResponse {
  RefferResponse({
    this.data,
    this.result,
    this.message,
  });

  List<Datum> data;
  bool result;
  String message;

  factory RefferResponse.fromJson(Map<String, dynamic> json) => RefferResponse(
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
    this.mobile,
    this.email,
    this.notes,
    this.addedBy,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String name;
  String mobile;
  String email;
  String notes;
  String addedBy;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        email: json["email"],
        notes: json["notes"],
        addedBy: json["added_by"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "email": email,
        "notes": notes,
        "added_by": addedBy,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

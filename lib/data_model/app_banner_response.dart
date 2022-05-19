// To parse this JSON data, do
//
//     final appBannerResponse = appBannerResponseFromJson(jsonString);

import 'dart:convert';

AppBannerResponse appBannerResponseFromJson(String str) =>
    AppBannerResponse.fromJson(json.decode(str));

String appBannerResponseToJson(AppBannerResponse data) =>
    json.encode(data.toJson());

class AppBannerResponse {
  AppBannerResponse({
    this.data,
    this.result,
    this.message,
  });

  List<Datum> data;
  bool result;
  String message;

  factory AppBannerResponse.fromJson(Map<String, dynamic> json) =>
      AppBannerResponse(
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
    this.type,
    this.value,
  });

  int id;
  String type;
  String value;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        type: json["type"],
        value: json["value"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "value": value,
      };
}

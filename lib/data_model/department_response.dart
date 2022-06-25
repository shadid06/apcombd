// To parse this JSON data, do
//
//     final departmentResponse = departmentResponseFromJson(jsonString);

import 'dart:convert';

DepartmentResponse departmentResponseFromJson(String str) =>
    DepartmentResponse.fromJson(json.decode(str));

String departmentResponseToJson(DepartmentResponse data) =>
    json.encode(data.toJson());

class DepartmentResponse {
  DepartmentResponse({
    this.data,
    this.result,
    this.message,
  });

  List<Datum> data;
  bool result;
  String message;

  factory DepartmentResponse.fromJson(Map<String, dynamic> json) =>
      DepartmentResponse(
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
    this.departmentName,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String departmentName;
  DateTime createdAt;
  DateTime updatedAt;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        departmentName: json["department_name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "department_name": departmentName,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}

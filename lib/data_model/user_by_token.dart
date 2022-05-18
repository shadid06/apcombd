// To parse this JSON data, do
//
//     final userByTokenResponse = userByTokenResponseFromJson(jsonString);

import 'dart:convert';

UserByTokenResponse userByTokenResponseFromJson(String str) =>
    UserByTokenResponse.fromJson(json.decode(str));

String userByTokenResponseToJson(UserByTokenResponse data) =>
    json.encode(data.toJson());

class UserByTokenResponse {
  UserByTokenResponse({
    this.result,
    this.id,
    this.name,
    this.email,
    this.avatar,
    this.avatar_original,
    this.phone,
    this.isWholesale,
    this.referredBy,
  });

  bool result;
  int id;
  String name;
  String email;
  String avatar;
  String avatar_original;
  String phone;
  int isWholesale; //string silo
  int referredBy;
  factory UserByTokenResponse.fromJson(Map<String, dynamic> json) =>
      UserByTokenResponse(
          result: json["result"] == null ? null : json["result"],
          id: json["id"] == null ? null : json["id"],
          name: json["name"] == null ? null : json["name"],
          email: json["email"] == null ? null : json["email"],
          avatar: json["avatar"] == null ? null : json["avatar"],
          avatar_original:
              json["avatar_original"] == null ? null : json["avatar_original"],
          phone: json["phone"] == null ? null : json["phone"],
          isWholesale: json["is_wholesale"],
          referredBy: json["referred_by"]);

  Map<String, dynamic> toJson() => {
        "result": result == null ? null : result,
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "email": email == null ? null : email,
        "avatar": avatar == null ? null : avatar,
        "avatar_original": avatar_original == null ? null : avatar_original,
        "phone": phone == null ? null : phone,
        "is_wholesale": isWholesale,
        "referred_by": referredBy,
      };
}

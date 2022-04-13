// // To parse this JSON data, do
// //
// //     final askQuotationResponse = askQuotationResponseFromJson(jsonString);

// import 'dart:convert';

// AskQuotationResponse askQuotationResponseFromJson(String str) =>
//     AskQuotationResponse.fromJson(json.decode(str));

// String askQuotationResponseToJson(AskQuotationResponse data) =>
//     json.encode(data.toJson());

// class AskQuotationResponse {
//   AskQuotationResponse({
//     this.data,
//     this.result,
//     this.message,
//   });

//   Data data;
//   bool result;
//   String message;

//   factory AskQuotationResponse.fromJson(Map<String, dynamic> json) =>
//       AskQuotationResponse(
//         data: Data.fromJson(json["data"]),
//         result: json["result"],
//         message: json["message"],
//       );

//   Map<String, dynamic> toJson() => {
//         "data": data.toJson(),
//         "result": result,
//         "message": message,
//       };
// }

// class Data {
//   Data({
//     this.id,
//     this.referredBy,
//     this.providerId,
//     this.userType,
//     this.name,
//     this.email,
//     this.emailVerifiedAt,
//     this.verificationCode,
//     this.newEmailVerificiationCode,
//     this.deviceToken,
//     this.avatar,
//     this.avatarOriginal,
//     this.address,
//     this.country,
//     this.state,
//     this.city,
//     this.postalCode,
//     this.phone,
//     this.isWholesale,
//     this.quotationSubmitted,
//     this.quotationReceived,
//     this.quotationViewed,
//     this.wholesaleRefName,
//     this.balance,
//     this.banned,
//     this.referralCode,
//     this.customerPackageId,
//     this.remainingUploads,
//     this.createdAt,
//     this.updatedAt,
//   });

//   int id;
//   dynamic referredBy;
//   dynamic providerId;
//   String userType;
//   String name;
//   String email;
//   DateTime emailVerifiedAt;
//   dynamic verificationCode;
//   dynamic newEmailVerificiationCode;
//   dynamic deviceToken;
//   dynamic avatar;
//   dynamic avatarOriginal;
//   dynamic address;
//   dynamic country;
//   dynamic state;
//   dynamic city;
//   dynamic postalCode;
//   dynamic phone;
//   String isWholesale;
//   int quotationSubmitted;
//   String quotationReceived;
//   String quotationViewed;
//   String wholesaleRefName;
//   String balance;
//   String banned;
//   dynamic referralCode;
//   dynamic customerPackageId;
//   String remainingUploads;
//   DateTime createdAt;
//   DateTime updatedAt;

//   factory Data.fromJson(Map<String, dynamic> json) => Data(
//         id: json["id"],
//         referredBy: json["referred_by"],
//         providerId: json["provider_id"],
//         userType: json["user_type"],
//         name: json["name"],
//         email: json["email"],
//         emailVerifiedAt: DateTime.parse(json["email_verified_at"]),
//         verificationCode: json["verification_code"],
//         newEmailVerificiationCode: json["new_email_verificiation_code"],
//         deviceToken: json["device_token"],
//         avatar: json["avatar"],
//         avatarOriginal: json["avatar_original"],
//         address: json["address"],
//         country: json["country"],
//         state: json["state"],
//         city: json["city"],
//         postalCode: json["postal_code"],
//         phone: json["phone"],
//         isWholesale: json["is_wholesale"],
//         quotationSubmitted: json["quotation_submitted"],
//         quotationReceived: json["quotation_received"],
//         quotationViewed: json["quotation_viewed"],
//         wholesaleRefName: json["wholesale_ref_name"],
//         balance: json["balance"],
//         banned: json["banned"],
//         referralCode: json["referral_code"],
//         customerPackageId: json["customer_package_id"],
//         remainingUploads: json["remaining_uploads"],
//         createdAt: DateTime.parse(json["created_at"]),
//         updatedAt: DateTime.parse(json["updated_at"]),
//       );

//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "referred_by": referredBy,
//         "provider_id": providerId,
//         "user_type": userType,
//         "name": name,
//         "email": email,
//         "email_verified_at": emailVerifiedAt.toIso8601String(),
//         "verification_code": verificationCode,
//         "new_email_verificiation_code": newEmailVerificiationCode,
//         "device_token": deviceToken,
//         "avatar": avatar,
//         "avatar_original": avatarOriginal,
//         "address": address,
//         "country": country,
//         "state": state,
//         "city": city,
//         "postal_code": postalCode,
//         "phone": phone,
//         "is_wholesale": isWholesale,
//         "quotation_submitted": quotationSubmitted,
//         "quotation_received": quotationReceived,
//         "quotation_viewed": quotationViewed,
//         "wholesale_ref_name": wholesaleRefName,
//         "balance": balance,
//         "banned": banned,
//         "referral_code": referralCode,
//         "customer_package_id": customerPackageId,
//         "remaining_uploads": remainingUploads,
//         "created_at": createdAt.toIso8601String(),
//         "updated_at": updatedAt.toIso8601String(),
//       };
// }

// To parse this JSON data, do
//
//     final askQuotationResponse = askQuotationResponseFromJson(jsonString);

import 'dart:convert';

AskQuotationResponse askQuotationResponseFromJson(String str) =>
    AskQuotationResponse.fromJson(json.decode(str));

String askQuotationResponseToJson(AskQuotationResponse data) =>
    json.encode(data.toJson());

class AskQuotationResponse {
  AskQuotationResponse({
    this.result,
    this.message,
  });

  bool result;
  String message;

  factory AskQuotationResponse.fromJson(Map<String, dynamic> json) =>
      AskQuotationResponse(
        result: json["result"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "message": message,
      };
}

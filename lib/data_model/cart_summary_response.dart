// // To parse this JSON data, do
// //
// //     final cartSummaryResponse = cartSummaryResponseFromJson(jsonString);

// import 'dart:convert';

// CartSummaryResponse cartSummaryResponseFromJson(String str) => CartSummaryResponse.fromJson(json.decode(str));

// String cartSummaryResponseToJson(CartSummaryResponse data) => json.encode(data.toJson());

// class CartSummaryResponse {
//   CartSummaryResponse({
//     this.sub_total,
//     this.tax,
//     this.shipping_cost,
//     this.discount,
//     this.grand_total,
//     this.grand_total_value,
//     this.coupon_code,
//     this.coupon_applied
//   });

//   String sub_total;
//   String tax;
//   String shipping_cost;
//   String discount;
//   String grand_total;
//   double grand_total_value;
//   String coupon_code;
//   bool coupon_applied;

//   factory CartSummaryResponse.fromJson(Map<String, dynamic> json) => CartSummaryResponse(
//     sub_total: json["sub_total"],
//     tax: json["tax"],
//     shipping_cost: json["shipping_cost"],
//     discount: json["discount"],
//     grand_total: json["grand_total"],
//     grand_total_value: json["grand_total_value"].toDouble(),
//     coupon_code: json["coupon_code"],
//     coupon_applied: json["coupon_applied"],
//   );

//   Map<String, dynamic> toJson() => {
//     "sub_total": sub_total,
//     "tax": tax,
//     "shipping_cost": shipping_cost,
//     "discount": discount,
//     "grand_total": grand_total,
//     "grand_total_value": grand_total_value,
//     "coupon_code": coupon_code,
//     "coupon_applied": coupon_applied,
//   };
// }

// To parse this JSON data, do
//
//     final cartSummaryResponse = cartSummaryResponseFromJson(jsonString);

import 'dart:convert';

CartSummaryResponse cartSummaryResponseFromJson(String str) =>
    CartSummaryResponse.fromJson(json.decode(str));

String cartSummaryResponseToJson(CartSummaryResponse data) =>
    json.encode(data.toJson());

class CartSummaryResponse {
  CartSummaryResponse({
    this.subTotal,
    this.tax,
    this.shippingCost,
    this.discount,
    this.grandTotal,
    this.grandTotalValue,
    this.couponCode,
    this.couponApplied,
    this.message,
    this.status,
  });

  String subTotal;
  String tax;
  String shippingCost;
  String discount;
  String grandTotal;
  dynamic grandTotalValue;
  dynamic couponCode;
  bool couponApplied;
  String message;
  bool status;

  factory CartSummaryResponse.fromJson(Map<String, dynamic> json) =>
      CartSummaryResponse(
        subTotal: json["sub_total"],
        tax: json["tax"],
        shippingCost: json["shipping_cost"],
        discount: json["discount"],
        grandTotal: json["grand_total"],
        grandTotalValue: json["grand_total_value"],
        couponCode: json["coupon_code"],
        couponApplied: json["coupon_applied"],
        message: json["message"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "sub_total": subTotal,
        "tax": tax,
        "shipping_cost": shippingCost,
        "discount": discount,
        "grand_total": grandTotal,
        "grand_total_value": grandTotalValue,
        "coupon_code": couponCode,
        "coupon_applied": couponApplied,
        "message": message,
        "status": status,
      };
}

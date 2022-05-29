import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:active_ecommerce_flutter/data_model/payment_type_response.dart';
import 'package:active_ecommerce_flutter/data_model/order_create_response.dart';
import 'package:active_ecommerce_flutter/data_model/paypal_url_response.dart';
import 'package:active_ecommerce_flutter/data_model/flutterwave_url_response.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:active_ecommerce_flutter/data_model/razorpay_payment_success_response.dart';
import 'package:active_ecommerce_flutter/data_model/paystack_payment_success_response.dart';
import 'package:active_ecommerce_flutter/data_model/iyzico_payment_success_response.dart';
import 'package:active_ecommerce_flutter/data_model/bkash_begin_response.dart';
import 'package:active_ecommerce_flutter/data_model/bkash_payment_process_response.dart';
import 'package:active_ecommerce_flutter/data_model/nagad_begin_response.dart';
import 'package:active_ecommerce_flutter/data_model/nagad_payment_process_response.dart';

import 'package:active_ecommerce_flutter/data_model/sslcommerz_begin_response.dart';

class PaymentRepository {
  String endPoint;
  Future<List<PaymentTypeResponse>> getPaymentResponseList(
      {mode = "", list = "both"}) async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/payment-types?mode=$mode&list=$list");
    final response = await http.get(url, headers: {
      "App-Language": app_language.$,
    });

    return paymentTypeResponseFromJson(response.body);
  }

  Future<OrderCreateResponse> getOrderCreateResponse(
      @required paymentMethod) async {
    var postBody = jsonEncode(
        {"user_id": "${user_id.$}", "payment_type": "$paymentMethod"});

    Uri url = Uri.parse("${AppConfig.BASE_URL}/order/store");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$,
        },
        body: postBody);

    print(response.body.toString());
    return orderCreateResponseFromJson(response.body);
  }

  Future<PaypalUrlResponse> getPaypalUrlResponse(@required String paymentType,
      @required int combinedOrderId, @required double amount) async {
    Uri url = Uri.parse(
      "${AppConfig.BASE_URL}/paypal/payment/url?payment_type=$paymentType&combined_order_id=$combinedOrderId&amount=$amount&user_id=${user_id.$}",
    );
    final response = await http.get(url, headers: {
      "App-Language": app_language.$,
    });

    //print(response.body.toString());
    return paypalUrlResponseFromJson(response.body);
  }

  Future<FlutterwaveUrlResponse> getFlutterwaveUrlResponse(
      @required String paymentType,
      @required int combinedOrderId,
      @required double amount) async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/flutterwave/payment/url?payment_type=$paymentType&combined_order_id=$combinedOrderId&amount=$amount&user_id=${user_id.$}");

    final response = await http.get(url, headers: {
      "App-Language": app_language.$,
    });

    //print(url);
    //print(response.body.toString());
    return flutterwaveUrlResponseFromJson(response.body);
  }

  Future<OrderCreateResponse> getOrderCreateResponseFromWallet(
      @required paymentMethod, @required double amount) async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/payments/pay/wallet");

    var postBody = jsonEncode({
      "user_id": "${user_id.$}",
      "payment_type": "$paymentMethod",
      "amount": "$amount"
    });

    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$
        },
        body: postBody);

    //print(response.body.toString());
    return orderCreateResponseFromJson(response.body);
  }

  Future<OrderCreateResponse> getOrderCreateResponseFromCod(
      @required paymentMethod, dynamic id) async {
    if (is_wholesale.$ == 1) {
      endPoint = "wholesalepayments";
    } else {
      endPoint = "payments";
    }
    var postBody = jsonEncode({
      "user_id": "${user_id.$}",
      "payment_type": "$paymentMethod",
      "referrer": "$id",
      "shipping_type": "home_delivery",
      //pickup_points //home_delivery
      "order_from": "App"
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL}/$endPoint/pay/cod");

    final response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}"
        },
        body: postBody);
    print(url);
    print(response.body);
    print(response.statusCode);
    return orderCreateResponseFromJson(response.body);
  }

  Future<OrderCreateResponse> getOrderCreateResponseFromManualPayment(
      @required paymentMethod) async {
    var postBody = jsonEncode(
        {"user_id": "${user_id.$}", "payment_type": "$paymentMethod"});

    Uri url = Uri.parse("${AppConfig.BASE_URL}/payments/pay/manual");

    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$
        },
        body: postBody);

    //print(response.body.toString());
    return orderCreateResponseFromJson(response.body);
  }

  Future<RazorpayPaymentSuccessResponse> getRazorpayPaymentSuccessResponse(
      @required paymentType,
      @required double amount,
      @required int combinedOrderId,
      @required String paymentDetails) async {
    var postBody = jsonEncode({
      "user_id": "${user_id.$}",
      "payment_type": "$paymentType",
      "combined_order_id": "$combinedOrderId",
      "amount": "$amount",
      "payment_details": "$paymentDetails"
    });

    print(postBody.toString());

    Uri url = Uri.parse("${AppConfig.BASE_URL}/razorpay/success");

    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$
        },
        body: postBody);

    //print(response.body.toString());
    return razorpayPaymentSuccessResponseFromJson(response.body);
  }

  Future<PaystackPaymentSuccessResponse> getPaystackPaymentSuccessResponse(
      @required paymentType,
      @required double amount,
      @required int combinedOrderId,
      @required String paymentDetails) async {
    var postBody = jsonEncode({
      "user_id": "${user_id.$}",
      "payment_type": "$paymentType",
      "combined_order_id": "$combinedOrderId",
      "amount": "$amount",
      "payment_details": "$paymentDetails"
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL}/paystack/success");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}"
        },
        body: postBody);

    //print(response.body.toString());
    return paystackPaymentSuccessResponseFromJson(response.body);
  }

  Future<IyzicoPaymentSuccessResponse> getIyzicoPaymentSuccessResponse(
      @required paymentType,
      @required double amount,
      @required int combinedOrderId,
      @required String paymentDetails) async {
    var postBody = jsonEncode({
      "user_id": "${user_id.$}",
      "payment_type": "$paymentType",
      "combined_order_id": "$combinedOrderId",
      "amount": "$amount",
      "payment_details": "$paymentDetails"
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL}/paystack/success");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}"
        },
        body: postBody);

    //print(response.body.toString());
    return iyzicoPaymentSuccessResponseFromJson(response.body);
  }

  Future<BkashBeginResponse> getBkashBeginResponse(
      @required String paymentType,
      @required int combinedOrderId,
      @required double amount) async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/bkash/begin?payment_type=$paymentType&combined_order_id=$combinedOrderId&amount=$amount&user_id=${user_id.$}");

    final response = await http.get(
      url,
      headers: {"Authorization": "Bearer ${access_token.$}"},
    );

    print(response.body.toString());
    return bkashBeginResponseFromJson(response.body);
  }

  Future<BkashPaymentProcessResponse> getBkashPaymentProcessResponse(
      @required paymentType,
      @required double amount,
      @required int combinedOrderId,
      @required String paymentDetails) async {
    var postBody = jsonEncode({
      "user_id": "${user_id.$}",
      "payment_type": "$paymentType",
      "combined_order_id": "$combinedOrderId",
      "amount": "$amount",
      "payment_details": "$paymentDetails"
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL}/bkash/api/process");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$,
        },
        body: postBody);

    //print(response.body.toString());
    return bkashPaymentProcessResponseFromJson(response.body);
  }

  Future<SslcommerzBeginResponse> getSslcommerzBeginResponse(
      @required String paymentType,
      @required int combinedOrderId,
      @required double amount) async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/sslcommerz/begin?payment_type=$paymentType&combined_order_id=$combinedOrderId&amount=$amount&user_id=${user_id.$}");

    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$
      },
    );

    print(response.body.toString());
    return sslcommerzBeginResponseFromJson(response.body);
  }

  Future<NagadBeginResponse> getNagadBeginResponse(
      @required String paymentType,
      @required int combinedOrderId,
      @required double amount) async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/nagad/begin?payment_type=$paymentType&combined_order_id=$combinedOrderId&amount=$amount&user_id=${user_id.$}");

    final response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$
      },
    );

    print(response.body.toString());
    return nagadBeginResponseFromJson(response.body);
  }

  Future<NagadPaymentProcessResponse> getNagadPaymentProcessResponse(
      @required paymentType,
      @required double amount,
      @required int combinedOrderId,
      @required String paymentDetails) async {
    var postBody = jsonEncode({
      "user_id": "${user_id.$}",
      "payment_type": "$paymentType",
      "combined_order_id": "$combinedOrderId",
      "amount": "$amount",
      "payment_details": "$paymentDetails"
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL}/nagad/process");

    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$,
        },
        body: postBody);

    //print(response.body.toString());
    return nagadPaymentProcessResponseFromJson(response.body);
  }
}

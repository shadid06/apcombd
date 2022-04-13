import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/data_model/ask_quotation_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'package:active_ecommerce_flutter/data_model/cart_response.dart';
import 'package:active_ecommerce_flutter/data_model/cart_delete_response.dart';
import 'package:active_ecommerce_flutter/data_model/cart_process_response.dart';
import 'package:active_ecommerce_flutter/data_model/cart_add_response.dart';
import 'package:active_ecommerce_flutter/data_model/cart_summary_response.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';

class CartRepository {
  String endPoint;
  Future<List<CartResponse>> getCartResponseList(
    @required int user_id,
  ) async {
    if (is_wholesale.$ == "1") {
      endPoint = "wholesalecart";
    } else {
      endPoint = "carts";
    }
    Uri url = Uri.parse("${AppConfig.BASE_URL}/$endPoint/$user_id"); //carts ?1
    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$,
      },
    );
    print(url);

    print(user_id);
    print(access_token.$);
    print('cart get response: ${response.body}');
    return cartResponseFromJson(response.body);
  }

  Future<CartDeleteResponse> getCartDeleteResponse(
    @required int cart_id,
  ) async {
    if (is_wholesale.$ == "1") {
      endPoint = "wholesalecart-remove";
    } else {
      endPoint = "carts";
    }
    Uri url = Uri.parse("${AppConfig.BASE_URL}/$endPoint/$cart_id"); //carts
    final response = await http.get(
      //http.delete
      url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$
      },
    );

    return cartDeleteResponseFromJson(response.body);
  }

  //ask for quotation

  // Future<CartDeleteResponse> quotationResponse(
  //   @required int cart_id,
  // ) async {
  //   Uri url = Uri.parse(
  //       "${AppConfig.BASE_URL}/wholesalecart-askforquotation"); //carts
  //   final response = await http.post(
  //     //http.delete
  //     url,
  //     headers: {
  //       "Content-Type": "application/json",
  //       "Accept": "application/json",
  //       "Authorization": "Bearer ${access_token.$}",
  //       "App-Language": app_language.$
  //     },
  //   );

  //   return cartDeleteResponseFromJson(response.body);
  // }

  Future<AskQuotationResponse> askQuotation() async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/wholesalecart/askforquotation"); //carts
    final response = await http.get(
      //http.delete
      url,
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$
      },
    );
    print(response.body);
    return askQuotationResponseFromJson(response.body);
  }

  Future<CartProcessResponse> getCartProcessResponse(
      @required String cart_ids, @required String cart_quantities) async {
    var post_body = jsonEncode(
        {"cart_ids": "${cart_ids}", "cart_quantities": "$cart_quantities"});

    Uri url = Uri.parse("${AppConfig.BASE_URL}/carts/process");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$
        },
        body: post_body);

    return cartProcessResponseFromJson(response.body);
  }

  Future<CartAddResponse> getCartAddResponse(
      @required int id,
      @required String variant,
      @required int user_id,
      @required int quantity) async {
    if (is_wholesale.$ == "1") {
      endPoint = "wholesalecart-addtowholesalecart";
    } else {
      endPoint = "carts/add";
    }

    var post_body = jsonEncode({
      "id": "${id}",
      "variant": "$variant",
      "user_id": "$user_id",
      "quantity": "$quantity",
      "cost_matrix": AppConfig.purchase_code
    });

    print('post body: ${post_body.toString()}');

    Uri url = Uri.parse("${AppConfig.BASE_URL}/$endPoint"); // /carts/add
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$
        },
        body: post_body);

    print('response body: ${response.body.toString()}');
    return cartAddResponseFromJson(response.body);
  }

  Future<CartSummaryResponse> getCartSummaryResponse() async {
    if (is_wholesale.$ == "1") {
      endPoint = "wholesalecart-summary";
    } else {
      endPoint = "cart-summary";
    }
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/$endPoint/${user_id.$}"); //cart-summary
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${access_token.$}",
        "App-Language": app_language.$
      },
    );

    print("${AppConfig.BASE_URL}/$endPoint/${user_id.$}"); //cart-summary
    return cartSummaryResponseFromJson(response.body);
  }
}

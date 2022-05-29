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
    @required int userId,
  ) async {
    if (is_wholesale.$ == 1) {
      endPoint = "wholesalecart";
    } else {
      endPoint = "carts";
    }
    Uri url = Uri.parse("${AppConfig.BASE_URL}/$endPoint/$userId"); //carts ?1
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

    print(userId);
    print(access_token.$);
    print('cart get response: ${response.body}');
    return cartResponseFromJson(response.body);
  }

  Future<CartDeleteResponse> getCartDeleteResponse(
    @required int cartId,
  ) async {
    http.Response response;
    if (is_wholesale.$ == 1) {
      endPoint = "wholesalecart_remove";
    } else {
      endPoint = "carts";
    }
    Uri url = Uri.parse("${AppConfig.BASE_URL}/$endPoint/$cartId"); //carts
    if (is_wholesale.$ == 1) {
      response = await http.get(
        //http.delete // http.get o dite hoi
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$
        },
      );
    } else {
      response = await http.delete(
        //http.delete // http.get o dite hoi
        url,
        headers: {
          "Content-Type": "application/json",
          "Accept": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$
        },
      );
    }

    print(url);
    print(response.body);
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
      @required String cartIds, @required String cartQuantities) async {
    if (is_wholesale.$ == 1) {
      endPoint = "wholesalecart/process";
    } else {
      endPoint = "carts/process";
    }
    var postBody = jsonEncode(
        {"cart_ids": "$cartIds", "cart_quantities": "$cartQuantities"});

    Uri url = Uri.parse("${AppConfig.BASE_URL}/$endPoint");
    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$
        },
        body: postBody);

    return cartProcessResponseFromJson(response.body);
  }

  Future<CartAddResponse> getCartAddResponse(
      @required int id,
      @required String variant,
      @required int userId,
      @required int quantity) async {
    if (is_wholesale.$ == 1) {
      endPoint = "wholesalecart-addtowholesalecart";
    } else {
      endPoint = "carts/add";
    }

    var postBody = jsonEncode({
      "id": "$id",
      "variant": "$variant",
      "user_id": "$userId",
      "quantity": "$quantity",
      "cost_matrix": AppConfig.purchase_code
    });

    print('post body: ${postBody.toString()}');

    Uri url = Uri.parse("${AppConfig.BASE_URL}/$endPoint"); // /carts/add
    final response = await http.post(url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}",
          "App-Language": app_language.$
        },
        body: postBody);

    print('response body: ${response.body.toString()}');
    return cartAddResponseFromJson(response.body);
  }

  Future<CartSummaryResponse> getCartSummaryResponse() async {
    if (is_wholesale.$ == 1) {
      endPoint = "wholesalecart-status";
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
    print(response.body);
    return cartSummaryResponseFromJson(response.body);
  }
}

import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:active_ecommerce_flutter/data_model/review_response.dart';
import 'package:active_ecommerce_flutter/data_model/review_submit_response.dart';

import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:flutter/foundation.dart';

class ReviewRepository {
  Future<ReviewResponse> getReviewResponse(@required int productId,{page = 1}) async {

    Uri url = Uri.parse("${AppConfig.BASE_URL}/reviews/product/$productId?page=$page");
    final response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${access_token.$}","App-Language": app_language.$,
      },
    );
    return reviewResponseFromJson(response.body);
  }

  Future<ReviewSubmitResponse> getReviewSubmitResponse(
      @required int productId,
      @required int rating,
      @required String comment,
      ) async {
    var postBody = jsonEncode({
      "product_id": "$productId",
      "user_id": "${user_id.$}",
      "rating": "$rating",
      "comment": "$comment"
    });

    Uri url = Uri.parse("${AppConfig.BASE_URL}/reviews/submit");
    final response =
    await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${access_token.$}","App-Language": app_language.$,
        },
        body: postBody);

    return reviewSubmitResponseFromJson(response.body);
  }


}

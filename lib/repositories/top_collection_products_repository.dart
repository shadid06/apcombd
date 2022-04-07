import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/data_model/to_collection_response.dart';
import 'package:active_ecommerce_flutter/data_model/top_collection_products_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class TopCollectionProductsRepository {
  Future<TopCollectionProductsResponse> getTopCollectionProductsResponseList(
      int collectionId) async {
    Uri url = Uri.parse(
        "${AppConfig.BASE_URL}/collection-product-view?collection_id=$collectionId"); //carts
    final response = await http.post(url);
    print(response.body);
    return topCollectionProductsResponseFromJson(response.body);
  }
}

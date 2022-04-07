import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/data_model/to_collection_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'dart:convert';

class TopCollectionRepository {
  Future<TopCollectionResponse> getTopCollectionResponseList() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/collections-list"); //carts
    final response = await http.get(url);

    return topCollectionResponseFromJson(response.body);
  }
}

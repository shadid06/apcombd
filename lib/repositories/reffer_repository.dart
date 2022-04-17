import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/data_model/reffer_response.dart';
import 'package:http/http.dart' as http;

class RefferRepository {
  Future<RefferResponse> getRefferList() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/referrer-list");

    final response = await http.post(url);

    print(response.body);
    return refferResponseFromJson(response.body);
  }
}

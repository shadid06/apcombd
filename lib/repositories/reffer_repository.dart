import 'dart:convert';

import 'package:active_ecommerce_flutter/app_config.dart';
import 'package:active_ecommerce_flutter/data_model/department_response.dart';
import 'package:active_ecommerce_flutter/data_model/reffer_response.dart';
import 'package:active_ecommerce_flutter/helpers/shared_value_helper.dart';
import 'package:http/http.dart' as http;

class RefferRepository {
  Future<RefferResponse> getRefferList() async {
    Uri url = Uri.parse("${AppConfig.BASE_URL}/referrer-list");

    final response = await http.post(url);

    print(response.body);
    return refferResponseFromJson(response.body);
  }

  Future<DepartmentResponse> getReferredDepartment(int id) async {
    var postBody = jsonEncode({"referred_by_id": "$id"});
    print(id);

    Uri url = Uri.parse("${AppConfig.BASE_URL}/user-wise-department-list");

    final response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "App-Language": app_language.$,
        },
        body: postBody);

    print('department: ${response.body}');
    return departmentResponseFromJson(response.body);
  }
}

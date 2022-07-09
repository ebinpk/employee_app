import 'package:employee_app/datamodel/employee_detail_model.dart';
import 'package:employee_app/helper/url_class.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
class EmployeeDetailsApi{

  static Future<List<EmployeeDetailModel>> getEmployeeData() async{

    final response = await http.get(
      Uri.parse(UrlClass.baseurl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      List data = jsonDecode(response.body);
      return data
          .map((itemData) =>  EmployeeDetailModel.fromJson(itemData))
          .toList();
    } else {
      return [];
    }

  }
}

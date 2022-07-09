

import 'package:employee_app/datamodel/employee_detail_model.dart';

import 'employee_details_api.dart';

class EmployeeDetailsRepository{

  late List<EmployeeDetailModel> data;


  Future<List<EmployeeDetailModel>> getEmployeeData() async{
    await EmployeeDetailsApi.getEmployeeData().then((value) => {
      data=value,

    });
    if(data.isNotEmpty){
      return data;
    }else{
      throw Exception();
    }

  }



}
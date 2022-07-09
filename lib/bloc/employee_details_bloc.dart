import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:employee_app/datamodel/employee_detail_model.dart';
import 'package:employee_app/repository/employee_details_repository.dart';
import 'package:flutter/material.dart';

import '../datamodel/company_db_model.dart';
import '../helper/db_helper.dart';


part 'employee_details_event.dart';
part 'employee_details_state.dart';

class EmployeeDetailsBloc extends Bloc<EmployeeDetailsEvent, EmployeeDetailsState> {
  final EmployeeDetailsRepository employeeDetailsRepository;
  EmployeeDetailsBloc(this.employeeDetailsRepository):super(EmployeeDetailsState());

  @override
  Stream<EmployeeDetailsState> mapEventToState(EmployeeDetailsEvent event) async* {

    if(event is EmployeeDetailsLoading){
      try {
        final item = await employeeDetailsRepository.getEmployeeData();
        DatabaseHelper helper = DatabaseHelper.instance;
        helper.deleteAll();
        for(int i=0;i<item.length;i++){
          EmployeeHdrModel model=EmployeeHdrModel(nEmployeeId: item[i].id,name:item[i].name,username:item[i].username,
              email:item[i].email,profileImage:item[i].profileImage,phone:item[i].phone,website:item[i].website);
          int id = await helper.employeeHdrInsert(model);
          AddressModel adModel=  AddressModel(nEmployeeId: id,street: item[i].address?.street,suite:item[i].address?.suite,city:item[i].address?.city,zipcode:item[i].address?.zipcode );
          await helper.AddressInsert(adModel);
          CompanyModel cModel=CompanyModel(nEmployeeId: id,cName: item[i].company?.name,cCatchPhrase: item[i].company?.catchPhrase,cBs: item[i].company?.bs);
          await helper.companyInsert(cModel);
          GeoLocationModel gModel=GeoLocationModel(nEmployeeId: id,lat: item[i].geo?.lat,lng: item[i].geo?.lng);
          await helper.LocationInsert(gModel);
        }
        List<ListDataModel>  data= await helper.queryGetListData();
        yield state.copyWith(data: item, employeeDetailsStatus: const EmployeeDetailsDataSuccess(),listData: data);



      }catch(e){
        yield state.copyWith(employeeDetailsStatus: EmployeeDetailsDataFailed(e.toString()));
      }


    }else if(event is EmployeeSearchLoading){
      DatabaseHelper helper = DatabaseHelper.instance;
      List<ListDataModel>  data= await helper.queryGetSearchedListData(event.keyword);
      yield state.copyWith(employeeDetailsStatus: const EmployeeDetailsDataSuccess(),listData: data);
    }else if(event is DetailsLoading){
      DatabaseHelper helper = DatabaseHelper.instance;
      List<DetailsModel> dData=await helper.queryGetDetails(event.nEmployeeId);
      yield state.copyWith(employeeDetailsStatus: const EmployeeDetailsDataSuccess(),detailData: dData);
    }
  }
}

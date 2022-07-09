part of 'employee_details_bloc.dart';



class EmployeeDetailsState  {

  List<EmployeeDetailModel> data;
  List<ListDataModel> listData;
  EmployeeDetailsDataStatus employeeDetailsStatus;
  List<DetailsModel> detailData;
  EmployeeDetailsState ({this.data=const [],this.employeeDetailsStatus=const EmployeeDetailsDataLoading(),this.listData=const[],this.detailData=const[]});
  EmployeeDetailsState copyWith({List<EmployeeDetailModel>? data,EmployeeDetailsDataStatus? employeeDetailsStatus,List<ListDataModel>? listData,List<DetailsModel>? detailData}){
    return EmployeeDetailsState(
        data: data??this.data,
        employeeDetailsStatus:employeeDetailsStatus??this.employeeDetailsStatus,
      listData: listData??this.listData,
      detailData: detailData??this.detailData

    );
  }
}

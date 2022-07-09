part of 'employee_details_bloc.dart';

@immutable
abstract class EmployeeDetailsEvent {}
class EmployeeDetailsLoading extends EmployeeDetailsEvent{

  EmployeeDetailsLoading();
}
class EmployeeSearchLoading extends EmployeeDetailsEvent{
  String keyword;
  EmployeeSearchLoading(this.keyword);
}

class DetailsLoading extends EmployeeDetailsEvent{
  int  nEmployeeId;
  DetailsLoading(this.nEmployeeId);
}
abstract class EmployeeDetailsDataStatus{
  const EmployeeDetailsDataStatus();
}

class EmployeeDetailsDataLoading extends EmployeeDetailsDataStatus{
  const EmployeeDetailsDataLoading();
}
class EmployeeDetailsDataSuccess extends EmployeeDetailsDataStatus{
  const EmployeeDetailsDataSuccess();
}
class EmployeeDetailsDataFailed extends EmployeeDetailsDataStatus{
  String error;
  EmployeeDetailsDataFailed(this.error);
}
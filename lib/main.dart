import 'package:employee_app/bloc/employee_details_bloc.dart';
import 'package:employee_app/repository/employee_details_repository.dart';
import 'package:employee_app/ui/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Employee App',
      theme: ThemeData(visualDensity: VisualDensity.adaptivePlatformDensity,
          primarySwatch: Colors.blue),
      home: RepositoryProvider(
        create: (context) => EmployeeDetailsRepository(),
        child: BlocProvider(
          create: (context) => EmployeeDetailsBloc(EmployeeDetailsRepository()),
          child: HomePage(),
        ),
      ),
    );
  }
}





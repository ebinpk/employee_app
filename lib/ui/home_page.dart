
import 'dart:async';

import 'package:employee_app/bloc/employee_details_bloc.dart';
import 'package:employee_app/ui/employee_details.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../repository/employee_details_repository.dart';



class HomePage extends StatefulWidget {


  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<EmployeeDetailsBloc>().add(EmployeeDetailsLoading());
  }





  @override
  Widget build(BuildContext context) {
return MaterialApp(
  home: Scaffold(
    appBar: AppBar( title: const Text('Employee App'),
    ),
    body: BlocListener<EmployeeDetailsBloc, EmployeeDetailsState>(
  listener: (context, state) async {
    // TODO: implement listener
    if (state.employeeDetailsStatus is EmployeeDetailsDataSuccess){


    }
  },
  child: Column(
      children: [
        _searchBox(),
         Container(
           child:SingleChildScrollView(child: _listView()) ,
         )



      ],
    ),
),
  ),
);


  }

  Widget _searchBox(){
    return Container(
      width: MediaQuery.of(context).size.width,

      alignment: Alignment.centerRight,
      child: Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
              left: MediaQuery.of(context).size.width * 0.04,
              right: MediaQuery.of(context).size.width * 0.04),
          alignment: Alignment.center,

          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.black12,
              ),
              borderRadius:
              const BorderRadius.all(Radius.circular(10))),
          child:  TextFormField(

                  controller: searchController,
                  onChanged: (value) => {
                  context.read<EmployeeDetailsBloc>().add(EmployeeSearchLoading(value.toString()))
                  },

                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: ('Search Name'),
                    prefixIcon: Padding(
                      padding: EdgeInsets.only(top: 0),
                      child: Icon(Icons.search),
                    ),
                  ),
                  style: const TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Work Sans'))
            ),
    );
  }


  Widget _listView(){
    return BlocBuilder<EmployeeDetailsBloc, EmployeeDetailsState>(builder: (context, state)
    {
      return
        ListView.builder(
            itemCount: state.listData.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (BuildContext contextList,int index) {
              return GestureDetector(
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) =>  RepositoryProvider(
                        create: (context) => EmployeeDetailsRepository(),
                        child: BlocProvider(
                          create: (context) => EmployeeDetailsBloc(EmployeeDetailsRepository()),
                          child: EmployeeDetailsPage(state.listData[index].nEmployeeId!),
                        )
                    ),),
                  );
                },
                child: ListTile(
                  title: Text(state.listData[index].name.toString()),
                  subtitle: Text(state.listData[index].companyName.toString()=='null'?'':state.listData[index].companyName.toString()),
                  leading: CircleAvatar(backgroundImage: NetworkImage(
                      state.listData[index].profileImage.toString())),
                ),
              );
            }
        );
    });
  }



  @override
  void dispose() {
    super.dispose();
  }
}

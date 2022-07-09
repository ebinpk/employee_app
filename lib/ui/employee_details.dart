import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/employee_details_bloc.dart';

class EmployeeDetailsPage extends StatefulWidget {
  int nEmployeeId;
  EmployeeDetailsPage(this.nEmployeeId);

  @override
  DetailsState createState() => DetailsState(this.nEmployeeId);
}

class DetailsState extends State<EmployeeDetailsPage> {
  int nEmployeeId;

  DetailsState(this. nEmployeeId);
  @override
  void initState() {
    super.initState();
    context.read<EmployeeDetailsBloc>().add(DetailsLoading(nEmployeeId));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Employee Details'),
          leading: IconButton(
            iconSize: 36,
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
              size: 36.0,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: BlocListener<EmployeeDetailsBloc, EmployeeDetailsState>(
            listener: (context, state) async {
          // TODO: implement listener
          if (state.employeeDetailsStatus is EmployeeDetailsDataSuccess) {}
        }, child: BlocBuilder<EmployeeDetailsBloc, EmployeeDetailsState>(
                builder: (context, state) {
          return ListView(
            children: <Widget>[
              Container(
                height: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children:  <Widget>[
                        CircleAvatar(
                          backgroundColor: Colors.white70,
                          minRadius: 60.0,
                          child: CircleAvatar(
                            radius: 50.0,
                            backgroundImage: NetworkImage(state.detailData.isEmpty?'':state.detailData[0].profileImage.toString()),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                     Text(
                      state.detailData.isEmpty?'':state.detailData[0].name.toString()+"("+state.detailData[0].username.toString()+")",
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                     Text(
                      state.detailData.isEmpty?'':state.detailData[0].companyName.toString(),
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Column(
                  children:  <Widget>[
                    ListTile(
                      title: Text(
                        'Email',
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        state.detailData.isEmpty?'':state.detailData[0].email.toString(),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Phone Number',
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        state.detailData.isEmpty?'':state.detailData[0].phone.toString(),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Divider(),

                    ListTile(
                      title: Text(
                        'Address',
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                      state.detailData.isEmpty?'':state.detailData[0].suite.toString()+","+state.detailData[0].street.toString()+","+state.detailData[0].city.toString()+","+state.detailData[0].zipcode.toString(),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        'Website',
                        style: TextStyle(
                          color: Colors.deepOrange,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                      state.detailData.isEmpty?'':state.detailData[0].website.toString(),
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ),

                  ],
                ),
              )
            ],
          );
        })),
      ),
    );
  }
}

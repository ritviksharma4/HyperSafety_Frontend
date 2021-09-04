// ignore: file_names
// ignore_for_file: file_names, prefer_const_constructors, use_key_in_widget_constructors, duplicate_ignore, deprecated_member_use, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_import, unused_element, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:hr_tech_solutions/Screens/Add_Employee.dart';
import 'package:hr_tech_solutions/Screens/Delete_Employee.dart';
import 'package:hr_tech_solutions/Screens/Employee_Records.dart';
import 'package:hr_tech_solutions/Screens/Reset_Record.dart';

// Test Files.
// import 'package:hr_tech_solutions/Screens/Add_Employee_Test.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.red, // AppBar Color.
        title: Center(
            child: Text("Employee Management",
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white, //Color(0xff689d6a), //Color of Title
                ))),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 100.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 160.0,
                      height: 160.0,
                      child: RaisedButton(
                        child: Image.asset("assets/Images/Add_Employee.png"),
                        elevation: 20.0,
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),  
                        onPressed: () {
                          _navigateToNextScreen(context, AddEmployeeScreen());
                        },
                      ),
                    ),
                    SizedBox(
                      width: 160.0,
                      height: 160.0,
                      child: RaisedButton(
                        child: Image.asset("assets/Images/Del_Employee.png"),
                        elevation: 20.0,
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {
                          _navigateToNextScreen(context, DeleteEmployeeScreen());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.fromLTRB(0.0, 50.0, 0.0, 100.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SizedBox(
                      width: 160.0,
                      height: 160.0,
                      child: RaisedButton(
                        child: Image.asset("assets/Images/Emp_Records.png"),
                        elevation: 20.0,
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {
                          _navigateToNextScreen(context, FetchEmployeeRecordScreen());
                        },
                      ),
                    ),
                    SizedBox(
                      width: 160.0,
                      height: 160.0,
                      child: RaisedButton(
                        child: Image.asset("assets/Images/Reset_Records.png"),
                        elevation: 20.0,
                        color: Colors.red,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        onPressed: () {
                          _navigateToNextScreen(context, ResetRecordsScreen());
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context, NewScreen) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => NewScreen));
  }
}
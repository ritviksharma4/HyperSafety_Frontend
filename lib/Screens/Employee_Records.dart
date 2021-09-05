// ignore_for_file: use_key_in_widget_constructors, unused_import, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, non_constant_identifier_names, unnecessary_this, unnecessary_string_interpolations, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';

import 'package:hr_tech_solutions/Emp_Model/Employee.dart';
import 'package:hr_tech_solutions/Sample_Employees/Sample_Employees.dart';
import 'package:hr_tech_solutions/Widgets/Scrollable_Widget.dart';
import 'package:hr_tech_solutions/Widgets/Tab_Bar_Widget.dart';
import 'package:hr_tech_solutions/Screens/Sortable_Screen.dart';


class FetchEmployeeRecordScreen extends StatefulWidget {
  @override
  _FetchEmployeeRecordScreenState createState() =>
      _FetchEmployeeRecordScreenState();
}

class _FetchEmployeeRecordScreenState extends State<FetchEmployeeRecordScreen> {
  
  int ? drop_down_value = 1;

  late List<Employee> employees;
  int? sortColumnIndex;
  bool isAscending = false;

  @override
  void initState() {
    super.initState();

    this.employees = List.of(all_employees);
  }

  @override
  Widget build(BuildContext context) => TabBarWidget(
        title: "Employee Records",
        tabs: [
          Tab(icon: Icon(Icons.all_inclusive), text: 'All Employees'),
          Tab(icon: Icon(Icons.warning), text: 'Exceeded Warnings'),
        ],
        children: [
          SortablePage(),
          SortablePage(),
        ],
      );

    // @override
    // Widget build(BuildContext context) => Scaffold(
    //   backgroundColor: Colors.blue,//Theme.of(context).primaryColor,
    //   appBar: AppBar(
    //     backgroundColor: Colors.red,
    //     centerTitle: true,
    //     title: Text("Employee Records",
    //         style: TextStyle(
    //           fontSize: 28.0,
    //           fontWeight: FontWeight.bold,
    //           color: Colors.white, //Color(0xff689d6a),
    //         )
    //       ),
    //   ),
    // );
}

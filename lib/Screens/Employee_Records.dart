// ignore_for_file: use_key_in_widget_constructors, unused_import, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, non_constant_identifier_names, unnecessary_this, unnecessary_string_interpolations, avoid_print, unused_local_variable, unused_element, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';

import 'package:hr_tech_solutions/Emp_Model/Employee.dart';
import 'package:hr_tech_solutions/Widgets/Scrollable_Widget.dart';
import 'package:hr_tech_solutions/Widgets/Tab_Bar_Widget.dart';
import 'package:hr_tech_solutions/Screens/Sortable_Screen_All_Emp.dart';
import 'package:hr_tech_solutions/Screens/Sortable_Screen_Warns_Only.dart';


// import 'package:hr_tech_solutions/Employees_List/Sample_Employees.dart';
import 'package:hr_tech_solutions/Employees_List/Employees_List.dart';


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

  TextEditingController warnings_alert = TextEditingController();
  String? codeDialogue;
  String? valueText;

  // List all_employees = <Employee> [];

  @override
  void initState() {
    super.initState();
    setState(() {
      // Employee new_emp = Employee( emp_name: 'Ritvik Sharma', emp_id: "RA021", warnings: 0);
      // all_employees.add(new_emp);
      // print(all_employees[0].emp_name); 
    });
    
    this.employees = List.of(all_employees);
  }

  @override
  Widget build(BuildContext context) => TabBarWidget(
        title: "Employee Records",
        tabs: [
          Tab(icon: Icon(Icons.all_inclusive), text: 'All Employees',),
          Tab(icon: Icon(Icons.warning), text: 'Exceeded Warnings'),
          
        ],
        children: [
          SortablePageAll(),
          SortablePageWarnsOnly(),
        ],
      );
}

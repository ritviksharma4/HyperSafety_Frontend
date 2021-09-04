// ignore_for_file: use_key_in_widget_constructors, unused_import, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields, non_constant_identifier_names, unnecessary_this

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';

import 'package:hr_tech_solutions/Emp_Model/Employee.dart';
import 'package:hr_tech_solutions/Sample_Employees/Sample_Employees.dart';
import 'package:hr_tech_solutions/Widgets/Scrollable_Widget.dart';


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

    this.employees = List.of(all_employess);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text("Employee Records",
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.white, //Color(0xff689d6a),
            )
          ),
      ),
      body: Column(children: <Widget>[
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(20),
              child:Align(
                alignment: Alignment.topCenter,
                child: DropdownButton(
                  icon: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                  ),
                  dropdownColor: Colors.white,
                  value: drop_down_value,
                  items: [
                    DropdownMenuItem(
                      child: Text("All Employees",),
                      value: 1,
                    ),
                    DropdownMenuItem(
                      child: Text("Exceeded Warnings"),
                      value: 2,
                    )
                  ],
                  onChanged: (value) {
                    setState(() {
                      drop_down_value = value as int?;
                      }
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        Row(
          children: [
            ScrollableWidget(child: buildDataTable())
          ],
        ),
      ],)
    );
  }

  

  Widget buildDataTable() {
    final columns = ['Emp Name', 'Emp Id', 'Warn'];

    return DataTable(
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      columns: getColumns(columns),
      rows: getRows(employees),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => 
    columns.map((String column) => DataColumn(
            label: Text(column),
            onSort: onSort,)
    ).toList();

  List<DataRow> getRows(List<Employee> employees) => employees.map((Employee employee) {
        final cells = [employee.emp_name, employee.emp_id, employee.warnings];
        return DataRow(cells: getCells(cells));
    }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((emp_data) => DataCell(Text('$emp_data'))).toList();

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 2) {
      employees.sort((employee1, employee2) => 
        compareString(ascending, '${employee1.warnings}', '${employee2.warnings}'));
    }
    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }
  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);
}

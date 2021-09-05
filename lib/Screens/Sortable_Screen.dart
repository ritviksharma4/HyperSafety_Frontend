// ignore_for_file: file_names, unused_import, unnecessary_this, non_constant_identifier_names, unnecessary_string_interpolations, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:hr_tech_solutions/Emp_Model/Employee.dart';
import 'package:hr_tech_solutions/Employees_List/Sample_Employees.dart';
import 'package:hr_tech_solutions/Widgets/Scrollable_Widget.dart';

class SortablePage extends StatefulWidget {
  @override
  SortablePageState createState() => SortablePageState();
}

class SortablePageState extends State<SortablePage> {
  
  late List<Employee> employees;
  int? sortColumnIndex;
  bool isAscending = false;

  @override
  void initState() {
    super.initState();

    this.employees = List.of(all_employees);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.white,
    body: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.grey,
          ),
      child: ScrollableWidget(child: buildDataTable())),
  );
  Widget buildDataTable() {
    final columns = ['Emp Name', 'Emp ID', 'Warnings'];

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
      cells.map((emp_data) => DataCell(Text('$emp_data'),)).toList();

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      employees.sort((employee1, employee2) => 
        compareString(ascending, '${employee1.emp_name}', '${employee2.emp_name}'));
    }
    else if (columnIndex == 1) {
      employees.sort((employee1, employee2) => 
        compareString(ascending, '${employee1.emp_id}', '${employee2.emp_id}'));
    }
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
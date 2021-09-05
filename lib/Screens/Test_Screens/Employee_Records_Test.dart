// ignore_for_file: use_key_in_widget_constructors, unnecessary_this, file_names, unused_import, non_constant_identifier_names

import 'package:hr_tech_solutions/Emp_Model/Employee.dart';
import 'package:hr_tech_solutions/Sample_Employees/Sample_Employees.dart';
import 'package:hr_tech_solutions/Widgets/Scrollable_Widget.dart';
import 'package:flutter/material.dart';

class SortablePwarnings extends StatefulWidget {
  @override
  _SortablePwarningsState createState() => _SortablePwarningsState();
}

class _SortablePwarningsState extends State<SortablePwarnings> {
  
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
        body: ScrollableWidget(child: buildDataTable()),
      );

  Widget buildDataTable() {
    final columns = ['Emp Name', 'Emp Id', 'Warnings'];

    return DataTable(
      sortAscending: isAscending,
      sortColumnIndex: sortColumnIndex,
      columns: getColumns(columns),
      rows: getRows(employees),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(column),
            onSort: onSort,
          ))
      .toList();

  List<DataRow> getRows(List<Employee> employees) => employees.map((Employee employee) {
        final cells = [employee.emp_name, employee.emp_id, employee.warnings];

        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) =>
      cells.map((emp_data) => DataCell(Text('$emp_data'))).toList();

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      employees.sort((employee1, employee2) =>
          compareString(ascending, employee1.emp_name, employee2.emp_name));
    } else if (columnIndex == 1) {
      employees.sort((employee1, employee2) =>
          compareString(ascending, employee1.emp_id, employee2.emp_id));
    } else if (columnIndex == 2) {
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
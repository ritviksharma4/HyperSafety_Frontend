// ignore: file_names
// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use, avoid_print, file_names, prefer_const_constructors, duplicate_ignore, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unused_element, non_constant_identifier_names, unused_import, avoid_unnecessary_containers, unnecessary_this, unnecessary_string_interpolations, duplicate_import, unnecessary_new

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:HyperSafety/API_NodeJS/API_NodeJS.dart';
import 'package:HyperSafety/Emp_Model/Employee.dart';
import 'package:HyperSafety/Screens/Home_Screen.dart';
import 'package:HyperSafety/Widgets/Scrollable_Widget.dart';
import 'package:HyperSafety/Screens/Login_Screen.dart';

class FetchEmployeeRecordsScreen extends StatefulWidget {
  @override
  _FetchEmployeeRecordsScreenState createState() =>
      _FetchEmployeeRecordsScreenState();
}

class _FetchEmployeeRecordsScreenState extends State<FetchEmployeeRecordsScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  List<Employee> employees = [];
  int? sortColumnIndex;
  bool isAscending = false;
  final List<String> categories = ["All Employees", "Exceeded Warnings"];
  int selectedIndex = 0;
  bool showAll = true;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: new Duration(seconds: 2), vsync: this);
    animationController!.repeat();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _acceptNodeResponse(showAll);
    });
  }

  _acceptNodeResponse(bool showAll) async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: animationController!.drive(ColorTween(
                  begin: Colors.lightBlue[600],
                  end: Colors.lightGreenAccent[400])),
            ),
          );
        });
    var node_response = await display_records(showAll);
    Navigator.pop(context);

    if (node_response is String) {
      if (node_response == "Go To Login Page.") {
        _navigateToNextScreen(context, LoginScreen());
        node_response = "Session Expired - Please Login Again.";
      }
      showSnackBar(context, node_response, Colors.red);
    } else {
      setState(() {
        this.employees = List.of(node_response);
      });
    }
  }

  Widget _addCategoryTab() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        height: 90.0,
        child: ListView.builder(
            physics: BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                    if (selectedIndex == 0) {
                      showAll = true;
                    } else {
                      showAll = false;
                    }
                  });
                  _acceptNodeResponse(showAll);
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 30.0),
                  child: Text(
                    categories[index],
                    style: TextStyle(
                      color: index == selectedIndex
                          ? Colors.white
                          : Colors.white60,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }

  Widget _addScrollableWidget() {
    return Container(
      child: ScrollableWidget(child: buildDataTable()),
    );
  }

  Widget buildDataTable() {
    final columns = ['Emp Name', 'Emp ID', 'Warnings'];
    return Theme(
      data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
      child: DataTable(
        sortAscending: isAscending,
        sortColumnIndex: sortColumnIndex,
        columns: getColumns(columns),
        rows: getRows(employees),
      ),
    );
  }

  List<DataColumn> getColumns(List<String> columns) => columns
      .map((String column) => DataColumn(
            label: Text(
              column,
              style: TextStyle(color: Colors.white),
            ),
            onSort: onSort,
          ))
      .toList();

  List<DataRow> getRows(List<Employee> employees) =>
      employees.map((Employee employee) {
        final cells = [employee.emp_name, employee.emp_id, employee.warnings];
        return DataRow(cells: getCells(cells));
      }).toList();

  List<DataCell> getCells(List<dynamic> cells) => cells
      .map((emp_data) => DataCell(
            Text(
              '$emp_data',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ))
      .toList();

  void onSort(int columnIndex, bool ascending) {
    if (columnIndex == 0) {
      employees.sort((employee1, employee2) => compareString(
          ascending, '${employee1.emp_name}', '${employee2.emp_name}'));
    } else if (columnIndex == 1) {
      employees.sort((employee1, employee2) => compareString(
          ascending, '${employee1.emp_id}', '${employee2.emp_id}'));
    }
    if (columnIndex == 2) {
      employees.sort((employee1, employee2) => compareString(
          ascending, '${employee1.warnings}', '${employee2.warnings}'));
    }
    setState(() {
      this.sortColumnIndex = columnIndex;
      this.isAscending = ascending;
    });
  }

  int compareString(bool ascending, String value1, String value2) =>
      ascending ? value1.compareTo(value2) : value2.compareTo(value1);

  void showSnackBar(BuildContext context, String text, Color status) {
    final snackBar = SnackBar(
      content: Text(
        text,
        textScaleFactor: 1.3,
      ),
      backgroundColor: status,
      duration: Duration(seconds: 2, milliseconds: 560), //default is 4s
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color(0xFF004e92),
                      Color(0xFF00095b),
                      Color(0xFF000742),
                    ],
                  ),
                ),
              ),
              Container(
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  padding:
                      EdgeInsets.symmetric(vertical: 35.0, horizontal: 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 15),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              color: Colors.white,
                              icon: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 25.5,
                              ),
                              onPressed: () {
                                _navigateToNextScreen(context, HomeScreen());
                              },
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 30.5),
                              child: Text(
                                "Employee Records",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                  fontSize: 30.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height -
                            kBottomNavigationBarHeight,
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            vertical: 20.0,
                          ),
                          child: Column(
                            children: <Widget>[
                              _addCategoryTab(),
                              _addScrollableWidget()
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToNextScreen(BuildContext context, NewScreen) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => NewScreen));
  }
}

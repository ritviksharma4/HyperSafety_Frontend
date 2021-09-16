// ignore: file_names
// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use, avoid_print, file_names, prefer_const_constructors, duplicate_ignore, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unused_element, non_constant_identifier_names, avoid_unnecessary_containers, prefer_final_fields, unused_field

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:HyperSafety/Screens/Home_Screen.dart';
import 'package:HyperSafety/Screens/Delete_Employee_Confirmation.dart';
import 'package:HyperSafety/Utilities/Utilities.dart';
import 'package:HyperSafety/API_NodeJS/API_NodeJS.dart';
import 'package:HyperSafety/Screens/Login_Screen.dart';

class DeleteEmployeeScreen extends StatefulWidget {
  static String specific_empName = "";
  static String specific_empId = "";
  static String specific_empWarnings = "";
  static String specific_empImageURL = "";
  static void reset_screen() {
    specific_empName = "";
    specific_empId = "";
  }

  @override
  _DeleteEmployeeScreenState createState() => _DeleteEmployeeScreenState();
}

class _DeleteEmployeeScreenState extends State<DeleteEmployeeScreen> {
  TextEditingController _empName = TextEditingController();
  TextEditingController _empId = TextEditingController();
  String _empWarnings = "";

  @override
  void initState() {
    super.initState();
    setState(() {
      _empName.text = DeleteEmployeeScreen.specific_empName;
      _empId.text = DeleteEmployeeScreen.specific_empId;
    });
  }

  Widget _DeleteConfirmationNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'NAME',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _empName,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.amber, width: 3.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.person,
                color: Colors.white,
              ),
              hintText: 'Enter Employee Name.',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _DeleteConfirmationIDField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          'EMPLOYEE ID',
          style: kLabelStyle,
        ),
        SizedBox(height: 10.0),
        Container(
          alignment: Alignment.centerLeft,
          decoration: kBoxDecorationStyle,
          height: 60.0,
          child: TextField(
            controller: _empId,
            keyboardType: TextInputType.emailAddress,
            style: TextStyle(
              color: Colors.white,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.amber, width: 3.0),
                borderRadius: BorderRadius.circular(10.0),
              ),
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.apps_rounded,
                color: Colors.white,
              ),
              hintText: 'Enter Employee ID.',
              hintStyle: kHintTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Widget _addSearchBtn() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0),
        width: double.infinity,
        child: RaisedButton(
          splashColor: Colors.lightGreenAccent,
          elevation: 15.0,
          onPressed: () async {
            if (_empName.text.isNotEmpty && _empId.text.isNotEmpty) {
              var node_response = await fetch_specific_employee_records(
                  _empName.text.trimRight().toLowerCase(),
                  _empId.text.trimRight());
              if (node_response is Map<String, dynamic>) {
                setState(() {
                  DeleteEmployeeScreen.specific_empName =
                      node_response["EmployeeName"];
                  DeleteEmployeeScreen.specific_empId =
                      node_response["EmployeeID"];
                  DeleteEmployeeScreen.specific_empWarnings =
                      node_response["Warnings"].toString();
                  DeleteEmployeeScreen.specific_empImageURL =
                      node_response["ImageURL"].toString();
                });
                _navigateToNextScreen(context, DeleteConfirmationScreen());
              } else if (node_response == "Go To Login Page.") {
                _navigateToNextScreen(context, LoginScreen());
                showSnackBar(context, "Session Expired - Please Login Again.",
                    Colors.red);
              } else {
                showSnackBar(context, node_response, Colors.red);
              }
            } else {
              if (_empName.text.isEmpty) {
                showSnackBar(context, "Name Field is Required.", Colors.red);
              } else if (_empId.text.isEmpty) {
                showSnackBar(context, "Employee ID is Required.", Colors.red);
              }
            }
          },
          padding: EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: Color.fromRGBO(255, 255, 255, 0.9),
          child: Text(
            "SEARCH",
            style: TextStyle(
              color: Color(0xFF527DAA),
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
              fontFamily: 'OpenSans',
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                                reset_screen();
                                _navigateToNextScreen(context, HomeScreen());
                              },
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 30.5),
                              child: Text(
                                "Delete Employee",
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
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                      ),
                      Container(
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 20.0,
                          ),
                          child: Column(
                            children: <Widget>[
                              _DeleteConfirmationNameField(),
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 10.0)),
                              _DeleteConfirmationIDField(),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0, vertical: 40.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: _addSearchBtn(),
                ),
              ),
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

  void reset_screen() {
    setState(() {
      DeleteEmployeeScreen.specific_empName = "";
      DeleteEmployeeScreen.specific_empId = "";
    });
  }
}
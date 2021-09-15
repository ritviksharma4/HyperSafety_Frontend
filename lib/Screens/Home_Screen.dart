// ignore: file_names
// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use, avoid_print, file_names, prefer_const_constructors, duplicate_ignore, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unused_element, non_constant_identifier_names, unused_import, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:HyperSafety/API_NodeJS/API_NodeJS.dart';
import 'package:HyperSafety/Screens/Add_Employee.dart';
import 'package:HyperSafety/Screens/Delete_Employee.dart';
import 'package:HyperSafety/Screens/Employee_Records.dart';
import 'package:HyperSafety/Screens/Reset_Record.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:HyperSafety/Screens/Login_Screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BackButtonInterceptor.add(myInterceptor);
  }

  bool myInterceptor(bool stopDefaultButtonEvent, RouteInfo info) {
    return true;
  }

  Widget _buildAddEmployeeBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        child: Container(
          child: Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset("assets/Images/Add_Employee.png",
                    width: 40.0, height: 40.0),
              ),
              Padding(padding: EdgeInsets.only(left: 10)),
              Expanded(
                child: Text(
                  'ADD EMPLOYEE',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFF527DAA),
                    letterSpacing: 1.25,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
              )
            ],
          ),
        ),
        splashColor: Colors.lightGreenAccent,
        elevation: 5.0,
        onPressed: () {
          _navigateToNextScreen(context, AddEmployeeScreen());
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
      ),
    );
  }

  Widget _buildDelEmployeebtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        child: Container(
          child: Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset("assets/Images/Del_Employee.png",
                    width: 40.0, height: 40.0),
              ),
              Padding(padding: EdgeInsets.only(left: 10)),
              Expanded(
                child: Text(
                  'DELETE EMPLOYEE',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFF527DAA),
                    letterSpacing: 1.25,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
              )
            ],
          ),
        ),
        splashColor: Colors.lightGreenAccent,
        elevation: 5.0,
        onPressed: () {
          _navigateToNextScreen(context, DeleteEmployeeScreen());
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
      ),
    );
  }

  Widget _buildDispEmployeebtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        child: Container(
          child: Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset("assets/Images/Emp_Records.png",
                    width: 40.0, height: 40.0),
              ),
              Padding(padding: EdgeInsets.only(left: 10)),
              Expanded(
                child: Text(
                  'DISPLAY EMPLOYEES',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFF527DAA),
                    letterSpacing: 1.25,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
              )
            ],
          ),
        ),
        splashColor: Colors.lightGreenAccent,
        elevation: 5.0,
        onPressed: () {
          _navigateToNextScreen(context, FetchEmployeeRecordsScreen());
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
      ),
    );
  }

  Widget _buildResetRecordbtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        child: Container(
          child: Row(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Image.asset("assets/Images/Reset_Records.png",
                    width: 40.0, height: 37),
              ),
              Padding(padding: EdgeInsets.only(left: 10)),
              Expanded(
                child: Text(
                  'RESET WARNINGS',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFF527DAA),
                    letterSpacing: 1.25,
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
              )
            ],
          ),
        ),
        splashColor: Colors.lightGreenAccent,
        elevation: 5.0,
        onPressed: () {
          _navigateToNextScreen(context, ResetRecordScreen());
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
      ),
    );
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
                child: SingleChildScrollView(
                  physics: AlwaysScrollableScrollPhysics(),
                  padding:
                      EdgeInsets.symmetric(vertical: 35.0, horizontal: 0.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 70),
                              child: Text(
                                "HTFE Services",
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
                          Padding(
                            padding: EdgeInsets.fromLTRB(0, 0, 30, 15),
                            child: IconButton(
                              padding: EdgeInsets.zero,
                              constraints: BoxConstraints(),
                              color: Colors.white,
                              icon: Icon(
                                Icons.power_settings_new_rounded,
                                color: Colors.deepOrange,
                                size: 40,
                              ),
                              onPressed: () {
                                _navigateToNextScreen(context, LoginScreen());
                              },
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            horizontal: 40.0,
                            vertical: 75.0,
                          ),
                          child: Column(
                            children: <Widget>[
                              _buildAddEmployeeBtn(),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10)),
                              _buildDispEmployeebtn(),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10)),
                              _buildResetRecordbtn(),
                              Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10)),
                              _buildDelEmployeebtn(),
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

// ignore: file_names
// ignore: file_names
// ignore: file_names
// ignore_for_file: use_key_in_widget_constructors, deprecated_member_use, avoid_print, file_names, prefer_const_constructors, duplicate_ignore, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unused_element, non_constant_identifier_names, avoid_unnecessary_containers, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hr_tech_solutions/API_NodeJS/API_NodeJS.dart';
import 'package:hr_tech_solutions/Utilities/Utilities.dart';

class DeleteEmployeeScreen extends StatefulWidget {
  @override
  _DeleteEmployeeScreenState createState() => _DeleteEmployeeScreenState();
}

class _DeleteEmployeeScreenState extends State<DeleteEmployeeScreen> {
  RegExp reg_exp = RegExp(r"(\w+)");

  TextEditingController _empName = TextEditingController();
  TextEditingController _empId = TextEditingController();

  Widget _addEmployeeNameField() {
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
            inputFormatters: [
              WhitelistingTextInputFormatter(RegExp(r"[a-zA-Z]+|\s")),
              BlacklistingTextInputFormatter(RegExp(r"^\s|[ ]{2,}")),
            ],
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

  Widget _addEmployeeIDField() {
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
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp('[ ]')),
            ],
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
        // color: Colors.amber,
        padding: EdgeInsets.symmetric(vertical: 20.0),
        width: double.infinity,
        child: RaisedButton(
          splashColor: Colors.lightGreenAccent,
          elevation: 15.0,
          onPressed: () async {
            if (_empName.text.isNotEmpty && _empId.text.isNotEmpty) {
              var node_response = await delete_employee(
                  _empName.text.trimRight().toLowerCase(),
                  _empId.text.trimRight());
              if (node_response == "Employee Successfully Deleted.") {
                showSnackBar(context, node_response, Colors.green);
                reset_screen();
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
            "SUBMIT",
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
                        children: [
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: IconButton(
                              color: Colors.white,
                              icon: Icon(
                                Icons.arrow_back_ios_new_rounded,
                                size: 25.5,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(35.0, 0, 0, 0),
                            child: Text(
                              'Delete Employee',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'OpenSans',
                                fontSize: 30.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
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
                              _addEmployeeNameField(),
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 10.0)),
                              _addEmployeeIDField(),
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
    _empName.clear();
    _empId.clear();
  }
}

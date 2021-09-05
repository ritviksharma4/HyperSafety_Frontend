// ignore_for_file: use_key_in_widget_constructors, unused_import, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, avoid_unnecessary_containers, prefer_final_fields, non_constant_identifier_names, unnecessary_new, unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hr_tech_solutions/API_NodeJS/API_NodeJS.dart';
import 'package:hr_tech_solutions/Custom_Library/timer_button.dart';

class ResetRecordsScreen extends StatefulWidget {
  @override
  _ResetRecordsScreenState createState() => _ResetRecordsScreenState();
}

class _ResetRecordsScreenState extends State<ResetRecordsScreen> {
  TextEditingController _empName = TextEditingController();
  TextEditingController _empId = TextEditingController();

  EdgeInsets padding_snackbar = EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text("Reset Record",
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.white, //Color(0xff689d6a), Title Color.
            )),
      ), //
      body: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 20.0),
          child: Column(
            children: [
              TextFormField(
                controller: _empName,
                style: TextStyle(
                  fontSize: 20.0,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.teal)),
                  hintText: "Employee Name",
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  labelText: "Name",
                  labelStyle: TextStyle(fontSize: 24, color: Colors.black),
                  fillColor: Colors.grey[400],
                  filled: true,
                ),
                inputFormatters: [
                  WhitelistingTextInputFormatter(RegExp(r"[a-zA-Z]+|\s")),                 
                  BlacklistingTextInputFormatter(RegExp(r"^\s|[ ]{2,}")),
                ],
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(
                      0.0, 20.0, 0.0, 0.0)), // Padding between 2 text fields
              TextFormField(
                controller: _empId,
                style: TextStyle(
                  fontSize: 20.0,
                ),
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 15.0),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: Colors.teal)),
                  hintText: "Employee ID",
                  hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 20.0),
                  labelText: "Employee ID",
                  labelStyle: TextStyle(fontSize: 24, color: Colors.black),
                  fillColor: Colors.grey[400],
                  filled: true,
                ),
                inputFormatters: [              
                  FilteringTextInputFormatter.deny(RegExp('[ ]')),
                ],
              ),
              Spacer(),
              AnimatedContainer(
                duration: Duration(milliseconds: 125),
                padding: padding_snackbar,
                child: SizedBox(
                  width: 220.0,
                  height: 50.0,
                  child: TimerButton(
                    timeOutInSeconds: 3,
                    color: Colors.red,
                    buttonType: ButtonType.RaisedButton,
                    label: "Submit",
                    onPressed: () async {
                      if (_empName.text.isNotEmpty &&
                            _empId.text.isNotEmpty) {
                          var node_response = await reset_records(_empName.text.trimRight().toLowerCase(), _empId.text.trimRight());
                          if (node_response == "Record Reset Successfully.") {
                            showSnackBar(
                                context, node_response, Colors.green);
                            reset_screen();
                          }
                          else {
                            showSnackBar(
                                context, node_response, Colors.red);
                          }
                        } else {
                          if (_empName.text.isEmpty) {
                            showSnackBar(
                                context, "Name Field is Required.", Colors.red);
                          } else if (_empId.text.isEmpty) {
                            showSnackBar(context, "Employee ID is Required.",
                                Colors.red);
                          }
                        }
                      setState(() {
                        FocusScope.of(context).unfocus();
                        padding_snackbar =
                            EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 40.0);
                        Future.delayed(const Duration(seconds: 3), () {
                          setState(() {
                            padding_snackbar =
                                EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0);
                          });
                        });
                      });
                    },
                    disabledTextStyle:
                        new TextStyle(fontSize: 23.0, color: Colors.white),
                    activeTextStyle:
                        new TextStyle(fontSize: 23.0, color: Colors.white),
                  ),
                ),
              ),
            ],
          )),
    );
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
    // Find the Scaffold in the widget tree and use it to show a SnackBar.
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void reset_screen() {
    _empName.clear();
    _empId.clear();
  }
}

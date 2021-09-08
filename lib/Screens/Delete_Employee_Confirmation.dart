// ignore_for_file: use_key_in_widget_constructors, unused_import, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, avoid_unnecessary_containers, import_of_legacy_library_into_null_safe, unused_local_variable, unused_field, avoid_init_to_null, prefer_final_fields, unnecessary_null_comparison, avoid_print, prefer_is_empty, non_constant_identifier_names, unnecessary_new, unused_label, sized_box_for_whitespace

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hr_tech_solutions/API_NodeJS/API_NodeJS.dart';
import 'package:async/async.dart';
import 'package:hr_tech_solutions/Utilities/Utilities.dart';

class DeleteConfirmationScreen extends StatefulWidget {
  @override
  _DeleteConfirmationScreenState createState() => _DeleteConfirmationScreenState();
}

class _DeleteConfirmationScreenState extends State<DeleteConfirmationScreen> {
  RegExp reg_exp = RegExp(r"(\w+)");

  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _isImagePicked = false;

  TextEditingController _empName = TextEditingController();
  TextEditingController _empId = TextEditingController();
  TextEditingController _empWarnings = TextEditingController();

  EdgeInsets padding_snackbar = EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0);

  Widget _addImgCircleAvatar() {
    return CircleAvatar(
      radius: 80,
      backgroundColor: Colors.white,
      child: CircleAvatar(
        radius: 78,
        backgroundColor: Color(0xFF004e92),
        backgroundImage: _imageFile == null
            ? AssetImage("assets/Images/Default_Emp_Image.png")
            : FileImage(File(_imageFile!.path)) as ImageProvider,
      ),
    );
  }

  Widget _DeleteConfirmationNameField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
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
              enabled: false,
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _DeleteConfirmationIDField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
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
              enabled: false,
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addWarningField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            'WARNINGS: ',
            style: kLabelStyle,
          ),
          SizedBox(height: 10.0),
          Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: TextField(
              controller: _empWarnings,
              enabled: false,
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
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addSubmitBtn() {
    return Container(
      child: Row(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
            child: ButtonTheme(
              minWidth: 150,
              height: 75,
              child: new RaisedButton(
                splashColor: Colors.lightGreenAccent,
                elevation: 15.0,
                color: Color.fromRGBO(255, 255, 255, 0.9),
                child: Text(
                  "SUBMIT",
                  style: TextStyle(
                    color: Color(0xFF527DAA),
                    letterSpacing: 1.5,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
                onPressed: () {},
                // padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          // Padding(padding: EdgeInsets.symmetric(horizontal: 30.0)),
          Padding(
            padding: EdgeInsets.fromLTRB(55, 0, 0, 0),
            child: ButtonTheme(
              minWidth: 150,
              height: 75,
              child: new RaisedButton(
                splashColor: Colors.lightGreenAccent,
                elevation: 15.0,
                color: Color.fromRGBO(255, 255, 255, 0.9),
                child: Text(
                  "CANCEL",
                  style: TextStyle(
                    color: Color(0xFF527DAA),
                    letterSpacing: 1.5,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
                onPressed: () {},
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  // Widget _addSubmitBtn() {
  //   return Container(
  //     padding: EdgeInsets.symmetric(vertical: 20.0),
  //     width: double.infinity,
  //     child: RaisedButton(
  // splashColor: Colors.lightGreenAccent,
  // elevation: 15.0,
  //       onPressed: () {
  //         display_details();
  //       },
  //       // onPressed: () async {
  //       //   if (_empName.text.isNotEmpty &&
  //       //       _empId.text.isNotEmpty &&
  //       //       _isImagePicked) {
  //       //     var node_response = await upload_image(
  //       //         File(_imageFile!.path),
  //       //         _empName.text.trimRight().toLowerCase(),
  //       //         _empId.text.trimRight());
  //       //     if (node_response == "Record Reset Successfully.") {
  //       //       showSnackBar(context, node_response, Colors.lightGreenAccent);
  //       //       reset_screen();
  //       //     } else {
  //       //       showSnackBar(context, node_response, Colors.red);
  //       //     }
  //       //   } else {
  //       //     if (_empName.text.isEmpty) {
  //       //       showSnackBar(context, "Name Field is Required.", Colors.red);
  //       //     } else if (_empId.text.isEmpty) {
  //       //       showSnackBar(context, "Employee ID is Required.", Colors.red);
  //       //     }
  //       //   }
  //       // },
  // padding: EdgeInsets.all(15.0),
  // shape: RoundedRectangleBorder(
  //   borderRadius: BorderRadius.circular(30.0),
  // ),
  // color: Color.fromRGBO(255, 255, 255, 0.9),
  // child: Text(
  //   "SUBMIT",
  //   style: TextStyle(
  //     color: Color(0xFF527DAA),
  //     letterSpacing: 1.5,
  //     fontSize: 18.0,
  //     fontWeight: FontWeight.bold,
  //     fontFamily: 'OpenSans',
  //   ),
  // ),
  //     ),
  //   );
  // }

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
                            alignment: Alignment.topLeft,
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
                            padding: EdgeInsets.fromLTRB(30.0, 0, 0, 0),
                            child: Text(
                              'Confirmation Page',
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
                            // horizontal: 40.0,
                            vertical: 20.0,
                          ),
                          child: Column(
                            children: <Widget>[
                              _addImgCircleAvatar(),
                              _DeleteConfirmationNameField(),
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 10.0)),
                              _DeleteConfirmationIDField(),
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 10.0)),
                              _addWarningField(),
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 50.0)),
                              _addSubmitBtn(),
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

  void showSnackBar(BuildContext context, String text, Color status) {
    final snackBar = SnackBar(
      content: Text(
        text,
        textScaleFactor: 1.3,
      ),
      backgroundColor: status,
      duration: Duration(seconds: 2, milliseconds: 560), //default is 4s
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar).closed.then(
          (reason) =>
              padding_snackbar = EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
        );
  }

  void reset_screen() {
    setState(() {
      _empName.clear();
      _empId.clear();
      _imageFile = null;
      _isImagePicked = false;
    });
  }

  void display_details() {
    setState(() {
      _empName.text = "Akul Jain";
      _empId.text = "RA007";
      _empWarnings.text = "333";
      _imageFile = null;
    });
  }
}
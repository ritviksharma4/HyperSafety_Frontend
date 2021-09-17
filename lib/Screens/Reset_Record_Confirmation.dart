// ignore_for_file: use_key_in_widget_constructors, unused_import, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, avoid_unnecessary_containers, import_of_legacy_library_into_null_safe, unused_local_variable, unused_field, avoid_init_to_null, prefer_final_fields, unnecessary_null_comparison, avoid_print, prefer_is_empty, non_constant_identifier_names, unnecessary_new, unused_label, sized_box_for_whitespace, library_prefixes

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:HyperSafety/API_NodeJS/API_NodeJS.dart';
import 'package:async/async.dart';
import 'package:HyperSafety/Utilities/Utilities.dart';
import 'package:HyperSafety/Screens/Reset_Record.dart' as ResetRecords;

class ResetConfirmationScreen extends StatefulWidget {
  @override
  _ResetConfirmationScreenState createState() =>
      _ResetConfirmationScreenState();
}

class _ResetConfirmationScreenState extends State<ResetConfirmationScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  String? _imageURL;
  final ImagePicker _picker = ImagePicker();
  bool _isImagePicked = false;

  TextEditingController _empName = TextEditingController();
  TextEditingController _empId = TextEditingController();
  TextEditingController _empWarnings = TextEditingController();

  EdgeInsets padding_snackbar = EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0);

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: new Duration(seconds: 2), vsync: this);
    animationController!.repeat();
    setState(() {
      _empName.text = ResetRecords.ResetRecordScreen.specific_empName;
      _empId.text = ResetRecords.ResetRecordScreen.specific_empId;
      _empWarnings.text = ResetRecords.ResetRecordScreen.specific_empWarnings;
      _imageURL = ResetRecords.ResetRecordScreen.specific_empImageURL;
    });
  }

  Widget _addImgCircleAvatar() {
    return CircleAvatar(
      radius: 77,
      backgroundColor: Colors.transparent,
      backgroundImage: AssetImage("assets/GIFs/Loading.gif"),
      child: CircleAvatar(
          radius: 78,
          backgroundColor: Colors.transparent,
          backgroundImage: NetworkImage(_imageURL!)),
    );
  }

  Widget _ResetConfirmationNameField() {
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

  Widget _ResetConfirmationIDField() {
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
            'WARNINGS',
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
                  Icons.warning,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _addConfirmationBtns() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: ButtonTheme(
              minWidth: 150,
              child: new RaisedButton(
                elevation: 15.0,
                color: Colors.red,
                child: Text(
                  "CANCEL",
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
                onPressed: () {
                  setState(() {
                    _navigateToNextScreen(
                        context, ResetRecords.ResetRecordScreen());
                  });
                },
                padding: EdgeInsets.all(15.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15),
            child: ButtonTheme(
              minWidth: 150,
              child: new RaisedButton(
                elevation: 15.0,
                color: Colors.green,
                child: Text(
                  "SUBMIT",
                  style: TextStyle(
                    color: Colors.white,
                    letterSpacing: 1.5,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'OpenSans',
                  ),
                ),
                onPressed: () async {
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
                  var node_response =
                      await reset_records(_empName.text, _empId.text);
                  Navigator.pop(context);
                  if (node_response == "Record Reset Successfully.") {
                    showSnackBar(context, node_response, Colors.green);
                    ResetRecords.ResetRecordScreen.reset_screen();
                    _navigateToNextScreen(
                        context, ResetRecords.ResetRecordScreen());
                  } else {
                    showSnackBar(context, node_response, Colors.red);
                    setState(() {
                      _navigateToNextScreen(
                          context, ResetRecords.ResetRecordScreen());
                    });
                  }
                },
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
                                _navigateToNextScreen(
                                    context, ResetRecords.ResetRecordScreen());
                              },
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 30.5),
                              child: Text(
                                "Confirmation",
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
                        child: SingleChildScrollView(
                          physics: AlwaysScrollableScrollPhysics(),
                          padding: EdgeInsets.symmetric(
                            vertical: 20.0,
                          ),
                          child: Column(
                            children: <Widget>[
                              _addImgCircleAvatar(),
                              _ResetConfirmationNameField(),
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 10.0)),
                              _ResetConfirmationIDField(),
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 10.0)),
                              _addWarningField(),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 60),
                alignment: Alignment.bottomCenter,
                child: _addConfirmationBtns(),
              ),
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

  void _navigateToNextScreen(BuildContext context, NewScreen) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => NewScreen));
  }
}

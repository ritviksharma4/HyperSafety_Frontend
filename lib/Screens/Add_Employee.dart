// ignore_for_file: use_key_in_widget_constructors, unused_import, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, avoid_unnecessary_containers, import_of_legacy_library_into_null_safe, unused_local_variable, unused_field, avoid_init_to_null, prefer_final_fields, unnecessary_null_comparison, avoid_print, prefer_is_empty, non_constant_identifier_names, unnecessary_new, unused_label, sized_box_for_whitespace

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:HyperSafety/Screens/Home_Screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:HyperSafety/API_NodeJS/API_NodeJS.dart';
import 'package:async/async.dart';
import 'package:HyperSafety/Utilities/Utilities.dart';
import 'package:HyperSafety/Screens/Login_Screen.dart';

class AddEmployeeScreen extends StatefulWidget {
  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen>
    with TickerProviderStateMixin {
  AnimationController? animationController;
  RegExp reg_exp = RegExp(r"(\w+)");

  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _isImagePicked = false;

  TextEditingController _empName = TextEditingController();
  TextEditingController _empId = TextEditingController();

  EdgeInsets padding_snackbar = EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0);
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: new Duration(seconds: 2), vsync: this);
    animationController!.repeat();
  }

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

  Widget _addUploadImageBtn() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 50, 0, 0),
      width: double.infinity,
      child: RaisedButton(
        splashColor: Colors.lightGreenAccent,
        elevation: 15.0,
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: ((builder) => bottomSheet()),
          );
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Color.fromRGBO(255, 255, 255, 0.9),
        child: Text(
          'UPLOAD IMAGE',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _addSubmitBtn() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      width: double.infinity,
      child: RaisedButton(
        splashColor: Colors.lightGreenAccent,
        elevation: 15.0,
        onPressed: () async {
          // Future.delayed(const Duration(seconds: 5),(){
          //   Navigator.pop(context);
          // });
          if (_empName.text.isNotEmpty &&
              _empId.text.isNotEmpty &&
              _isImagePicked) {
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
            var node_response = await upload_image(
                File(_imageFile!.path),
                _empName.text.trimRight().toLowerCase(),
                _empId.text.trimRight());
            Navigator.pop(context);

            if (node_response == "Employee Added Successfully.") {
              showSnackBar(context, node_response, Colors.green);
              reset_screen();
            } else if (node_response == "Go To Login Page.") {
              _navigateToNextScreen(context, LoginScreen());
              showSnackBar(
                  context, "Session Expired - Please Login Again.", Colors.red);
            } else {
              showSnackBar(context, node_response, Colors.red);
            }
          } else {
            if (_empName.text.isEmpty) {
              showSnackBar(context, "Name Field is Required.", Colors.red);
            } else if (_empId.text.isEmpty) {
              showSnackBar(context, "Employee ID is Required.", Colors.red);
            } else if (_isImagePicked == false) {
              showSnackBar(context, "Employee Image is Required.", Colors.red);
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
                  constraints: BoxConstraints.expand(),
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding:
                        EdgeInsets.symmetric(vertical: 35.0, horizontal: 0.0),
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.only(left: 10),
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
                                padding: const EdgeInsets.only(right: 35.5),
                                child: Text(
                                  "Add Employee",
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
                          padding: EdgeInsets.fromLTRB(40, 40, 40, 0),
                          child: Column(
                            children: <Widget>[
                              _addImgCircleAvatar(),
                              _addEmployeeNameField(),
                              Padding(
                                  padding:
                                      EdgeInsets.symmetric(vertical: 10.0)),
                              _addEmployeeIDField(),
                              _addUploadImageBtn(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )),
              Container(
                padding: EdgeInsets.fromLTRB(40, 40, 40, 60),
                alignment: Alignment.bottomCenter,
                child: _addSubmitBtn(),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        vertical: 20,
        horizontal: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Employee's Photo",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            FlatButton.icon(
              icon: Icon(
                Icons.camera,
                color: Colors.white,
              ),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text(
                "Camera",
                style: TextStyle(color: Colors.white),
              ),
            ),
            FlatButton.icon(
              icon: Icon(
                Icons.image,
                color: Colors.white,
              ),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text(
                "Gallery",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ])
        ],
      ),
    );
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(
      source: source,
    );
    setState(() {
      _imageFile = pickedFile;
      _isImagePicked = true;
      Navigator.pop(context);
    });
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

  void _navigateToNextScreen(BuildContext context, NewScreen) {
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => NewScreen));
  }
}

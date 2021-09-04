// ignore_for_file: use_key_in_widget_constructors, unused_import, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, deprecated_member_use, avoid_unnecessary_containers, import_of_legacy_library_into_null_safe, unused_local_variable, unused_field, avoid_init_to_null, prefer_final_fields, unnecessary_null_comparison, avoid_print, prefer_is_empty, non_constant_identifier_names, unnecessary_new, unused_label

import 'dart:async';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:image_picker/image_picker.dart';
import 'package:hr_tech_solutions/API_NodeJS/API_NodeJS.dart';
import 'package:async/async.dart';
import 'package:hr_tech_solutions/Custom_Library/timer_button.dart';

class AddEmployeeScreen extends StatefulWidget {
  @override
  _AddEmployeeScreenState createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {

  PickedFile? _imageFile;
  final ImagePicker _picker = ImagePicker();
  bool _isImagePicked = false;

  TextEditingController _empName = TextEditingController();
  TextEditingController _empId = TextEditingController();

  EdgeInsets padding_snackbar = EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text("Add New Employee",
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.white, //Color(0xff689d6a), Title Color.
            )),
      ), //
      body: Padding(
          padding: EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 80.0,
                backgroundImage: _imageFile == null
                    ? AssetImage("assets/Images/Default_Emp_Image.png")
                    : FileImage(File(_imageFile!.path))
                        as ImageProvider, //AssetImage("assets/Images/Add_Employee.png"),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
              ),
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
                  hintText: "New Employee Name",
                  hintStyle: TextStyle(color: Colors.blueGrey),
                  labelText: "Name",
                  labelStyle: TextStyle(fontSize: 24, color: Colors.black),
                  fillColor: Colors.grey[400],
                  filled: true,
                ),
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
                  hintText: "New Employee ID",
                  hintStyle: TextStyle(color: Colors.blueGrey, fontSize: 20.0),
                  labelText: "Employee ID",
                  labelStyle: TextStyle(fontSize: 24, color: Colors.black),
                  fillColor: Colors.grey[400],
                  filled: true,
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
                child: SizedBox(
                  width: 220.0,
                  height: 50.0,
                  child: RaisedButton(
                    elevation: 20.0,
                    color: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Center(
                      child: Text(
                        "Upload Image",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 23.0,
                        ),
                      ),
                    ),
                    textColor: Colors.white,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheet()),
                      );
                    },
                  ),
                ),
              ),
              Spacer(),
              AnimatedContainer(
                duration: Duration(milliseconds: 225),
                padding: padding_snackbar,
                child: SizedBox(
                  width: 220.0,
                  height: 50.0,
                  child: TimerButton(
                    label: "Submit",
                    color: Colors.red,
                    buttonType: ButtonType.RaisedButton,
                    onPressed: () async {
                      if (_empName.text.isNotEmpty &&
                            _empId.text.isNotEmpty &&
                            _isImagePicked) {
                            var node_response = await upload_image(File(_imageFile!.path), _empName.text, _empId.text);
                            if (node_response == "Successful") {
                              showSnackBar(context, "Successfully Added Employee.", Colors.green);
                              reset_screen();
                            }
                            else {
                                showSnackBar(context,
                                  node_response, Colors.red);
                            }
                        } 
                        else {
                          if (_empName.text.isEmpty) {
                            showSnackBar(context, "Name Field is Required.", Colors.red);
                          } 
                          else if (_empId.text.isEmpty) {
                            showSnackBar(context, "Employee ID is Required.", Colors.red);
                          } 
                          else if (_isImagePicked == false) {
                            showSnackBar(
                                context, "Employee Image is Required.", Colors.red);
                          }
                        }
                      setState(() {
                        FocusScope.of(context).unfocus();
                        padding_snackbar = EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 40.0);
                        Future.delayed(const Duration(seconds: 3), () {
                          setState(() {
                            padding_snackbar = EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0);
                          });
                        });
                      });
                    },
                    timeOutInSeconds: 3,
                    disabledTextStyle: new TextStyle(fontSize: 23.0, color: Colors.white),
                    activeTextStyle: new TextStyle(fontSize: 23.0, color: Colors.white),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100.0,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
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
              icon: Icon(Icons.camera),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text("Camera"),
            ),
            FlatButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("Gallery"),
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
      content: Text(text, textScaleFactor: 1.3,),
      backgroundColor: status,
      duration: Duration(seconds: 2, milliseconds: 560), //default is 4s
    );
    ScaffoldMessenger.of(context)
    .showSnackBar(snackBar)
    .closed.then((reason) => 
    padding_snackbar = EdgeInsets.fromLTRB(0.0, 30.0, 0.0, 0.0),
    );
  }

  void reset_screen(){
    _empName.clear();
    _empId.clear();
    _imageFile = null;
    _isImagePicked = false;
  }
}

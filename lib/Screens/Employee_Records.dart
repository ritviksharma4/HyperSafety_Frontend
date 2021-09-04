// ignore_for_file: use_key_in_widget_constructors, unused_import, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_final_fields

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/cupertino.dart';


class FetchEmployeeRecordScreen extends StatefulWidget {
  @override
  _FetchEmployeeRecordScreenState createState() =>
      _FetchEmployeeRecordScreenState();
}

class _FetchEmployeeRecordScreenState extends State<FetchEmployeeRecordScreen> {
  
  int ? _value = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Colors.red,
        centerTitle: true,
        title: Text("Employee Records",
            style: TextStyle(
              fontSize: 28.0,
              fontWeight: FontWeight.bold,
              color: Colors.white, //Color(0xff689d6a),
            )
          ),
      ),
      body:Container(
          padding: EdgeInsets.all(20),
          child:Align(
            alignment: Alignment.topCenter,
            child: DropdownButton(
              icon: Icon(
                Icons.arrow_drop_down,
                color: Colors.black,
              ),
              dropdownColor: Colors.white,
              value: _value,
              items: [
                DropdownMenuItem(
                  child: Text("All Employees",),
                  value: 1,
                ),
                DropdownMenuItem(
                  child: Text("Exceeded Warnings"),
                  value: 2,
                )
              ],
              onChanged: (value) {
                setState(() {
                  _value = value as int?;
                });
              },
              ),
          ),
          )
    );
  }
}

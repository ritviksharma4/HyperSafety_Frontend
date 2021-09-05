// ignore_for_file: unused_import, deprecated_member_use, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:hr_tech_solutions/Screens/Home_Screen.dart';
import 'package:hr_tech_solutions/Screens/Add_Employee.dart';
import 'package:hr_tech_solutions/Screens/Delete_Employee.dart';
import 'package:hr_tech_solutions/Screens/Employee_Records.dart';
import 'package:hr_tech_solutions/Screens/Reset_Record.dart';

// flutter run --no-sound-null-safety 
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HR-Tech-Solutions',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // brightness: Brightness.light,
        primaryColor: Colors.black, //Color(0xff1d2021), Color of Main Screen.
        accentColor: Color(0xFF282828),
        fontFamily: 'FiraCode',
        textTheme: Theme.of(context).textTheme.apply(
          bodyColor: Color(0xff32302f),//Colors.white,
          displayColor: Colors.white, //Color(0xff32302f),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
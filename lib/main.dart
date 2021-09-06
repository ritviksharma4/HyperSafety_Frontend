// ignore_for_file: unused_import, deprecated_member_use, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:hr_tech_solutions/Screens/Home_Screen.dart';
import 'package:hr_tech_solutions/Screens/Add_Employee.dart';
import 'package:hr_tech_solutions/Screens/Delete_Employee.dart';
import 'package:hr_tech_solutions/Screens/Employee_Records.dart';
import 'package:hr_tech_solutions/Screens/Reset_Record.dart';
import 'package:hr_tech_solutions/Screens/Login_Screen.dart';

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
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: Color(0xFF243b55))
      ),
      home: LoginScreen(),
    );
  }
}
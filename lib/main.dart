// ignore_for_file: unused_import, deprecated_member_use, prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:HyperSafety/Screens/Home_Screen.dart';
import 'package:HyperSafety/Screens/Add_Employee.dart';
import 'package:HyperSafety/Screens/Delete_Employee.dart';
import 'package:HyperSafety/Screens/Employee_Records.dart';
import 'package:HyperSafety/Screens/Reset_Record.dart';
import 'package:HyperSafety/Screens/Login_Screen.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

// flutter pub run flutter_launcher_icons:main
// flutter run --no-sound-null-safety
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HyperSafety',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          // dividerColor: Colors.blueGrey,
          iconTheme: IconThemeData(color: Colors.white),
          bottomSheetTheme:
              BottomSheetThemeData(backgroundColor: Color(0xFF243b55))),
      home: LoginScreen(),
    );
  }
}

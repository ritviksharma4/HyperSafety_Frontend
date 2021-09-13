// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:hr_tech_solutions/Screens/Login_Screen.dart';

class LogoScreen extends StatefulWidget {
  @override
  _LogoScreenState createState() => _LogoScreenState();
}

class _LogoScreenState extends State<LogoScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(milliseconds: 500), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: double.infinity,
      // width: double.infinity,
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
      child: Container(
        child: Align(
          alignment: Alignment.center,
          child: Image.asset('assets/Images/PlaceHolder_Logo.png',
                height: 200, fit: BoxFit.fill),
        ),
      ),
    );
  }
}
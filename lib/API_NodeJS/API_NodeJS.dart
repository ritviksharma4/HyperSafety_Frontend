// ignore_for_file: avoid_print, file_names, import_of_legacy_library_into_null_safe, unused_import, deprecated_member_use, unused_local_variable, non_constant_identifier_names, duplicate_import, prefer_typing_uninitialized_variables, prefer_const_constructors, avoid_function_literals_in_foreach_calls

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:async/async.dart';
import 'package:hr_tech_solutions/Employees_List/Exceeded_Warnings_List.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:hr_tech_solutions/Emp_Model/Employee.dart';

upload_image(File imageFile, String empName, String empId) async {
  var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
  var length = await imageFile.length();

  var host_ip = "192.168.29.30"; //Ritvik
  // var host_ip = "192.168.0.221"; //Akul
  //var host_ip = "192.168.1.41"; //Steve

  var uri = Uri.parse("http://" + host_ip + ":7091/api/employee_services");

  try {
    var request = http.MultipartRequest("POST", uri);
    request.fields["empName"] = empName;
    request.fields["empId"] = empId;

    var multipartFile = http.MultipartFile(
        'employee_image', imageFile.openRead(), length,
        filename: basename(imageFile.path));

    request.files.add(multipartFile);

    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode != 200) {
      var error_message = response.stream.bytesToString();
      return error_message;
    } else {
      var success_message = "Employee Added Successfully.";
      return success_message;
    }
  } catch (e) {
    return "Server Down - Please Try Again Later.";
  }
}

delete_employee(String empName, String empId) async {
  var host_ip = "192.168.29.30"; //Ritvik
  // var host_ip = "192.168.0.221"; //Akul
  // var host_ip = "192.168.1.41"; //Steve

  var uri = Uri.parse("http://" + host_ip + ":7091/api/employee_services");
  var body = jsonEncode({"empName": empName, "empId": empId});

  try {
    final request = http.Request("DELETE", uri);
    request.headers.addAll(<String, String>{
      "Content-Type": "application/json",
    });

    request.body = body;

    final response = await request.send();
    if (response.statusCode != 200) {
      var error_message = response.stream.bytesToString();
      return error_message;
    } else {
      var success_message = "Employee Successfully Deleted.";
      return success_message;
    }
  } catch (e) {
    return "Server Down - Please Try Again Later.";
  }
}

reset_records(String empName, String empId) async {
  var host_ip = "192.168.29.30"; //Ritvik
  // var host_ip = "192.168.0.221"; //Akul
  //var host_ip = "192.168.1.41"; //Steve

  var uri = Uri.parse("http://" + host_ip + ":7091/api/employee_services");
  var body = jsonEncode({"empName": empName, "empId": empId});

  try {
    final request = http.Request("PUT", uri);
    request.headers.addAll(<String, String>{
      "Content-Type": "application/json",
    });

    request.body = body;

    final response = await request.send();
    if (response.statusCode != 200) {
      var error_message = response.stream.bytesToString();
      return error_message;
    } else {
      var success_message = "Record Reset Successfully.";
      return success_message;
    }
  } catch (e) {
    return "Server Down - Please Try Again Later.";
  }
}

display_records(bool showAll) async {
  var host_ip = "192.168.29.30"; //Ritvik
  // var host_ip = "192.168.0.221"; //Akul
  //var host_ip = "192.168.1.41"; //Steve

  var uri = Uri.parse("http://" + host_ip + ":7091/api/employee_services");

  if (!showAll) {
    uri = Uri.parse("http://" + host_ip + ":7091/api/employee_services/3");
  }

  // final request = http.Request("GET", uri);
  try {
    final response = await http.get(uri);
    if (response.body != "Error - Try Again." && response.statusCode == 200) {
      List employee_details = jsonDecode(response.body);
      List<Employee> list_emp = [];
      employee_details.forEach((employee) {
        Employee node_resp_emp = Employee(
            emp_name: CapitalizeText(employee["EmployeeName"]),
            emp_id: employee["EmployeeID"],
            warnings: employee["Warnings"]);
        list_emp.add(node_resp_emp);
      });
      return list_emp;
    } else {
      var error_message = response.body;
      // print(error_message);
      return (error_message);
    }
  } catch (e) {
    return "Server Down - Please Try Again Later.";
  }
}

String CapitalizeText(String text) {
  List<String> text_to_capitalize = text.split(" ");

  for (int i = 0; i < text_to_capitalize.length; i++) {
    text_to_capitalize[i] = text_to_capitalize[i][0].toUpperCase() +
        text_to_capitalize[i].substring(1);
  }
  String capitalized_text = text_to_capitalize.join(" ");
  return capitalized_text;
}

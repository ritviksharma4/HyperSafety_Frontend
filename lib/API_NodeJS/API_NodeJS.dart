// ignore_for_file: avoid_print, file_names, import_of_legacy_library_into_null_safe, unused_import, deprecated_member_use, unused_local_variable, non_constant_identifier_names, duplicate_import, prefer_typing_uninitialized_variables, prefer_const_constructors, avoid_function_literals_in_foreach_calls, unnecessary_new, empty_catches, library_prefixes, prefer_collection_literals

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:HyperSafety/Emp_Model/Employee.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart'
    as FlutterSecureStorage;
import 'package:dio/dio.dart';

// var host_ip = "192.168.0.6"; //Vivek
// var host_ip = "192.168.0.221"; //Akul
// var host_ip = "192.168.0.6"; //Steve
var host_ip = "192.168.29.30"; //Ritvik
// var host_ip = "192.168.0.6"; //Harsh

BaseOptions options = new BaseOptions(
  baseUrl: "http://" + host_ip + ":7091/api",
  connectTimeout: 3000,
);
Dio dio = new Dio(options);

admin_login(String admin_email, String admin_pass) async {
  var uri = dio.options.baseUrl + "/admin_services/login";
  final jwt_storage = new FlutterSecureStorage.FlutterSecureStorage();
  String? jwt_token;
  var body = jsonEncode({"email": admin_email, "password": admin_pass});

  try {
    Response response = await dio.post(uri,
        data: body,
        options:
            Options(headers: {Headers.contentTypeHeader: "application/json"}));

    if (response.statusCode != 200) {
      var error_message = response.data;
      return error_message;
    } else {
      var login_response = (response.data);
      jwt_token = login_response["token"];
      await jwt_storage.write(key: 'jwt', value: jwt_token);
      return "Login Successful.";
    }
  } on DioError catch (e) {
    if (e.response != null) {
      return e.response.toString();
    } else {
      return "Unable to Connect to Server - Try Again.";
    }
  } catch (e) {
    print(e);
    return "Unexpected Error Occured - Try Again.";
  }
}

ping_node_server() async {
  var uri = dio.options.baseUrl + "/ping";
  var node_response;
  try {
    node_response = (await dio.get(uri)).data;
  } catch (e) {
    print(e);
    node_response = "Server Down - Please Try Again Later.";
  }

  return node_response;
}

upload_image(File imageFile, String empName, String empID) async {
  var ping = await ping_node_server();
  if (ping == "Server is up.") {
    final jwt_storage = new FlutterSecureStorage.FlutterSecureStorage();
    final _readJWTToken = await jwt_storage.read(key: "jwt");

    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse("http://" + host_ip + ":7091/api/employee_services");

    try {
      var request = http.MultipartRequest("POST", uri);
      request.headers["x-access-token"] = _readJWTToken;
      request.fields["empName"] = empName;
      request.fields["empID"] = empID;

      var multipartFile = http.MultipartFile(
          'employee_image', imageFile.openRead(), length,
          filename: basename(imageFile.path));

      request.files.add(multipartFile);

      var response = await request.send();
      if (response.statusCode == 401) {
        return "Go To Login Page.";
      } else if (response.statusCode != 200) {
        var error_message = response.stream.bytesToString();
        return error_message;
      } else {
        var success_message = "Employee Added Successfully.";
        return success_message;
      }
    } catch (e) {
      return "Unexpected Error Occured - Try Again.";
    }
  } else {
    return ping;
  }
}

delete_employee(String empName, String empID) async {
  final jwt_storage = new FlutterSecureStorage.FlutterSecureStorage();
  final _readJWTToken = await jwt_storage.read(key: "jwt");

  var uri = dio.options.baseUrl + "/employee_services";
  var body = jsonEncode({"empName": empName, "empID": empID});

  try {
    Map<String, dynamic> delete_header = new Map<String, dynamic>();
    delete_header["x-access-token"] = _readJWTToken;
    delete_header["Content-Type"] = "application/json";
    Response response = await dio.delete(
      uri,
      data: body,
      options: Options(headers: delete_header),
    );

    if (response.statusCode == 401) {
      return "Go To Login Page.";
    } else if (response.statusCode != 200) {
      var error_message = response.data;
      return error_message;
    } else {
      var success_message = "Employee Successfully Deleted.";
      return success_message;
    }
  } on DioError catch (e) {
    if (e.response != null) {
      if (e.response.statusCode == 401 || e.response.statusCode == 403) {
        return "Go To Login Page.";
      } else {
        return e.response.toString();
      }
    } else {
      return "Unable to Connect to Server - Try Again.";
    }
  } catch (e) {
    print(e);
    return "Unexpected Error Occured - Try Again.";
  }
}

reset_records(String empName, String empID) async {
  final jwt_storage = new FlutterSecureStorage.FlutterSecureStorage();
  final _readJWTToken = await jwt_storage.read(key: "jwt");

  var uri = dio.options.baseUrl + "/employee_services";
  var body = jsonEncode({"empName": empName, "empID": empID});

  try {
    Map<String, dynamic> reset_header = new Map<String, dynamic>();
    reset_header["x-access-token"] = _readJWTToken;
    reset_header["Content-Type"] = "application/json";
    Response response = await dio.put(
      uri,
      data: body,
      options: Options(headers: reset_header),
    );

    if (response.statusCode == 401) {
      return "Go To Login Page.";
    } else if (response.statusCode != 200) {
      var error_message = response.data.toString();
      return error_message;
    } else {
      var success_message = "Record Reset Successfully.";
      return success_message;
    }
  } on DioError catch (e) {
    if (e.response != null) {
      if (e.response.statusCode == 401 || e.response.statusCode == 403) {
        return "Go To Login Page.";
      } else {
        return e.response.toString();
      }
    } else {
      return "Unable to Connect to Server - Try Again.";
    }
  } catch (e) {
    print(e);
    return "Unexpected Error Occured - Try Again.";
  }
}

display_records(bool showAll) async {
  final jwt_storage = new FlutterSecureStorage.FlutterSecureStorage();
  final _readJWTToken = await jwt_storage.read(key: "jwt");

  var uri = dio.options.baseUrl + "/employee_services";

  if (!showAll) {
    uri = dio.options.baseUrl + "/employee_services/3";
  }

  try {
    Map<String, dynamic> display_header = new Map<String, dynamic>();
    display_header["x-access-token"] = _readJWTToken;
    Response response = await dio.get(
      uri,
      options: Options(headers: display_header),
    );
    var response_body = await response.data;

    if (response_body != "Error - Try Again." && response.statusCode == 200) {
      List employee_details = response_body;
      List<Employee> list_emp = [];
      employee_details.forEach((employee) {
        Employee node_resp_emp = Employee(
            emp_name: CapitalizeText(employee["EmployeeName"]),
            emp_id: employee["EmployeeID"],
            warnings: employee["Warnings"]);
        list_emp.add(node_resp_emp);
      });
      return list_emp;
    }
  } on DioError catch (e) {
    if (e.response != null) {
      if (e.response.statusCode == 401 || e.response.statusCode == 403) {
        return "Go To Login Page.";
      } else {
        return e.response.toString();
      }
    } else {
      return "Unable to Connect to Server - Try Again.";
    }
  } catch (e) {
    print(e);
    return "Unexpected Error Occured - Try Again.";
  }
}

fetch_specific_employee_records(String empName, String empID) async {
  final jwt_storage = new FlutterSecureStorage.FlutterSecureStorage();
  final _readJWTToken = await jwt_storage.read(key: "jwt");

  var uri = dio.options.baseUrl + "/employee_services/" + empID + "/" + empName;
  int empWarnings;
  try {
    Map<String, dynamic> fetch_header = new Map<String, dynamic>();
    fetch_header["x-access-token"] = _readJWTToken;
    Response response = await dio.get(
      uri,
      options: Options(headers: fetch_header),
    );
    var response_body = await response.data;
    if (response_body != "Error - Try Again." && response.statusCode == 200) {
      List employee_details = response_body;
      if (employee_details.isNotEmpty) {
        employee_details[0]["EmployeeName"] =
            CapitalizeText(employee_details[0]["EmployeeName"]);
        return employee_details[0];
      } else {
        return "Employee Not Found - Check the Details.";
      }
    } else if (response.statusCode == 401) {
      print(response.statusMessage);
      return "Go To Login Page.";
    } else {
      var error_message = response_body;
      return (error_message);
    }
  } on DioError catch (e) {
    if (e.response != null) {
      if (e.response.statusCode == 401 || e.response.statusCode == 403) {
        return "Go To Login Page.";
      } else {
        return e.response.toString();
      }
    } else {
      return "Unable to Connect to Server - Try Again.";
    }
  } catch (e) {
    print(e);
    return "Unexpected Error Occured - Try Again.";
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

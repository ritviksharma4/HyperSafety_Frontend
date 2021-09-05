// ignore_for_file: avoid_print, file_names, import_of_legacy_library_into_null_safe, unused_import, deprecated_member_use, unused_local_variable, non_constant_identifier_names, duplicate_import, prefer_typing_uninitialized_variables

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:async';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;


upload_image(File imageFile, String empName, String empId) async {

    var stream = http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    var length = await imageFile.length();

    var uri = Uri.parse("http://192.168.0.221:7091/api/employee_services");

    var request = http.MultipartRequest("POST", uri);
    request.fields["empName"] = empName;
    request.fields["empId"] = empId;

    var multipartFile = http.MultipartFile('employee_image', imageFile.openRead(), length, filename: basename(imageFile.path));

    request.files.add(multipartFile);

    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode != 200) {
      var error_message = response.stream.bytesToString();
      return error_message;
    }
    else {
      var success_message = "Successful";
    return success_message;
  }
}

delete_image(String empName, String empId) async {
  var uri = Uri.parse("http://192.168.0.221:7091/api/employee_services");
  var body = jsonEncode({"empName" : empName, "empId" : empId});
  final request = http.Request("DELETE", uri);
  request.headers.addAll(<String, String> {
    "Content-Type": "application/json",
  });

  request.body = body;

  final response = await request.send();
  if (response.statusCode != 200) {
    var error_message = response.stream.bytesToString();
    return error_message;
  }
  else {
    var success_message = "Successful";
    return success_message;
  }
}
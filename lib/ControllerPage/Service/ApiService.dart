import 'dart:io';
import 'package:aimedlabtask/ControllerPage/Model/SlipModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
  static var client = http.Client();
  static Future<SlipModel> fetchProducts(randomNumber) async {
    final String apiUrl = "https://api.adviceslip.com/advice/$randomNumber";
    final response = await http.get(apiUrl);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return slipModelFromJson(jsonString + "}");
    }
  }
}

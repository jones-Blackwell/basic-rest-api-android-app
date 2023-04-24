import 'dart:math';

import 'package:dio/src/response.dart';
import 'package:exercise_1/api/endpoints.dart';

import 'api/connector.dart';

class Controller {
  static Future<List<dynamic>> getData() async{
    final response =  await ApiConnector().get(Endpoints.group1);

    return response.data;
  }
}
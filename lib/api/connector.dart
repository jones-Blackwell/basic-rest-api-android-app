import 'package:dio/dio.dart';
import 'dio_client.dart';
import 'endpoint_model.dart';

class ApiConnector {
  late DioClient dioClient;

  ApiConnector({Dio? dioClient}) {
    this.dioClient = DioClient(Dio());
  }

  Future<Map<String, dynamic>> _authHeaders() async {
    return {
      "x-apikey": "63722be4c890f30a8fd1f370",
      "Content-Type": "application/json",
      "cache-control": "no-cache",
    };
  }

  Future<Response> post(
      {Map<String, dynamic>? data, required EndpointModel endpoint}) async {
    try {
      final options = Options();
      if (endpoint.restricted!) {
        options.headers = await _authHeaders();
      }
      final Response response = await dioClient.post(
        endpoint.uri!,
        data: data,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> get(EndpointModel endpoint) async {
    try {
      final options = Options();
      if (endpoint.restricted!) {
        options.headers = await _authHeaders();
      }
      final Response response = await dioClient.get(
        endpoint.uri!,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<void> delete({
    required EndpointModel endpoint,
    Map<String, dynamic>? data,
    dynamic uid,
  }) async {
    try {
      final options = Options();
      if (endpoint.restricted!) {
        options.headers = await _authHeaders();
      }
      final response = await dioClient.delete(
        endpoint.uri! + '/$uid',
        data: data,
        options: options,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}

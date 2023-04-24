import 'endpoint_model.dart';

class Endpoints {
  Endpoints._();
  static const GET = 'get';
  static const POST = 'post';
  static const DELETE = 'delete';
  static const PUT = 'put';

  static const String baseUrl = "https://exercise-b342.restdb.io";

  // receiveTimeout
  static const int receiveTimeout = 60000;

  // connectTimeout
  static const int connectionTimeout = 60000;

  static EndpointModel group1 = EndpointModel(
    uri: "/rest/group-1",
    restricted: true,
    method: GET,
  );
}

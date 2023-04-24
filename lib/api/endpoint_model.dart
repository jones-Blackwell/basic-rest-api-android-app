class EndpointModel {
  String? uri;
  bool? restricted;
  String? method;

  EndpointModel({
    this.uri,
    this.restricted,
    this.method,
  });

  EndpointModel.fromJson(Map<String, dynamic> json) {
    uri = json['uri'];
    restricted = json['restricted'];
    method = json['method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uri'] = uri;
    data['restricted'] = restricted;
    data['method'] = method;
    return data;
  }
}

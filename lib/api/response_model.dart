class ResponseModel {
  int status;
  String message;
  Map<String, dynamic> data;

  ResponseModel({
    this.status: 0,
    this.message: "",
    this.data: const {},
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    final model = ResponseModel();
    model.status = json['status'];
    model.message = json['message'];
    try {
      model.data = json['data'];
    } catch (e) {
      model.data = {};
    }

    return model;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = <String, dynamic>{};
    json['status'] = status;
    json['message'] = message;
    json['data'] = data;
    return json;
  }
}

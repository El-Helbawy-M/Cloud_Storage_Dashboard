import 'dart:io';

import 'package:test_data_flutter/Domain/Models/model.dart';
import 'package:test_data_flutter/Domain/Tools/mapFormater.dart';

class Object implements Model {
  @override
  String bucket, opjectName, fileExtension;
  ContentType _contentType;
  double size;
  Object(MapFormater map) {
    this.bucket = map.data["bucket"];
    this.opjectName = map.data["opjectName"];
    this.fileExtension = map.data["fileExtension"];
    this.size = double.parse(map.data["size"]);
  }

  @override
  getDetails() {
    // TODO: implement getDetails
    throw UnimplementedError();
  }
}

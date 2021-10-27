import 'dart:io';

import 'package:dio/dio.dart';
import 'package:ext_storage/ext_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:test_data_flutter/Data/Api/CloudStorageApi.dart';
import 'package:test_data_flutter/Data/Handlers/Handler.dart';
import 'package:test_data_flutter/Domain/Models/model.dart';
import 'package:test_data_flutter/Domain/Models/object.dart';
import 'package:test_data_flutter/Domain/Tools/filePicker.dart';
import 'package:test_data_flutter/Domain/Tools/mapFormater.dart';

class ObjectHandler extends CloudStorageApi with Handler {
  ObjectHandler(this.bucket);
  String bucket;
  Future<List<Object>> getAllObjects() async {
    Map data = await get("b/$bucket/o");
    List items = data["items"];
    List<Object> objects = items.map((opject) => Object(MapFormater.opjectData(opject["bucket"], opject["name"], opject["contentType"], opject["size"]))).toList();
    return objects;
  }

  Future<Object> getObject(String objectName) async {
    Map data = await get("b/$bucket/o/$objectName");
    return Object(MapFormater.opjectData(data["bucket"], data["name"], data["contentType"], data["size"]));
  }

  Future<int> downloadObject({
    @required String objectName,
    String fileName,
    Function(int, int) onReceiveProgress,
  }) async {
    var dir = await ExtStorage.getExternalStoragePublicDirectory(ExtStorage.DIRECTORY_DOWNLOADS);
    final pathName = "$dir/${objectName ?? "storageFile"}";
    Response response = await download(this.bucket, objectName, pathName, onReceiveProgress);
    return response.statusCode;
  }

  Future<int> uploadObject({
    @required String objectName,
    FileType type,
    Function(int, int) onSendingProgress,
  }) async {
    final File pathName = await Picker().pickFile(type ?? FileType.any);
    String extension = pathName.path.split(".").last;
    int length = await pathName.length();
    await upload(bucket, objectName, pathName.path, "*/$extension", length.toString(), onSendingProgress);
  }
}

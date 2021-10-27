import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:test_data_flutter/Data/Handlers/OpjectsHandler.dart';
import 'package:test_data_flutter/Domain/Models/object.dart';
import 'package:test_data_flutter/constants.dart';

class FileProvider extends ChangeNotifier {
  Object object;
  FileProvider(this.object);
  FileProvider.empty();
  double runSize = 0, maxSize = 0;
  bool inProgress = false;
  start(FileOperation op, [String fileName, String bucket]) async {
    _resetTime();
    try {
      if (op == FileOperation.Download)
        await ObjectHandler(this.object.bucket).downloadObject(objectName: this.object.opjectName, fileName: fileName, onReceiveProgress: (current, max) => _updateRunTime(current.toDouble(), max.toDouble()));
      else {
        print("object");
        await ObjectHandler(bucket ?? this.object.bucket).uploadObject(objectName: fileName, type: FileType.any, onSendingProgress: (current, max) => _updateRunTime(current.toDouble(), max.toDouble()));
      }
    } catch (e) {
      print(e);
    } finally {
      this.inProgress = false;
      notifyListeners();
    }
  }

  _resetTime() {
    this.inProgress = true;
    this.runSize = 0;
    this.maxSize = 0;
    notifyListeners();
  }

  _updateRunTime(double currentSize, double maxSize) {
    this.runSize = currentSize;
    this.maxSize = maxSize;
    notifyListeners();
  }
}

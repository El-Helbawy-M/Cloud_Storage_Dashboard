import 'dart:io';

import 'package:file_picker/file_picker.dart';

class Picker {
  Future<File> pickFile([FileType type]) async {
    FilePickerResult result = await FilePicker.platform.pickFiles(type: type);
    return File(result.files.single.path);
  }
}

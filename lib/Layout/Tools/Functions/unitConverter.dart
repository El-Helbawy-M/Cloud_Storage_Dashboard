String sizeConverter(double size) {
  if (size >= 1024) {
    int kb = size ~/ 1024;
    return "$kb KB";
  } else if (size >= 1024 * 1024) {
    int mb = size ~/ (1024 * 1024);
    return "$mb MB";
  } else if (size >= 1024 * 1024 * 1024) {
    int gb = size ~/ (1024 * 1024 * 1024);
    return "$gb GB";
  } else
    return "${size.toInt()} B";
}

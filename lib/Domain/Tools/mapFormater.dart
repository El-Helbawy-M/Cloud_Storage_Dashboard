class MapFormater {
  Map data;
  MapFormater.opjectData(String bucket, String opjectName, String fileExtension, String size) {
    this.data = {"bucket": bucket, "opjectName": opjectName, "fileExtension": fileExtension, "size": size};
  }
}

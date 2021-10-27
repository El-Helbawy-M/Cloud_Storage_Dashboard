import 'package:dio/dio.dart';
import 'package:test_data_flutter/Data/Api/Api.dart';

class CloudStorageApi implements Api {
  Dio dio = Dio(BaseOptions(
    baseUrl: "https://storage.googleapis.com/storage/v1/",
    headers: {"Authorization": "Bearer ya29.a0ARrdaM_m8G8Dn3B-YTqxPic7jxZwOfOmxpt5xyaYYlsi6FrKzpxRvgjWSCONLcNKM3xjC1pgWRa5yL-A_w6u402VIi15GqPNmJ2D6yE8czuwjQPNlOqIrm-VtafmJpeyc__-wZXz3Jn5czL72ztDbh-wQxH3"},
  ));
  @override
  get(String uri, [Map<String, dynamic> paramters]) async {
    Response response = await dio.get(uri, queryParameters: paramters);
    return response.data;
  }

  @override
  post(String uri, Map<String, dynamic> body, [Map<String, dynamic> paramters]) async {}

  Future<Response> download(
    String bucket,
    String objectName,
    String pathName,
    Function(int, int) onReceiveProgress,
  ) async =>
      await dio.download("b/$bucket/o", pathName, onReceiveProgress: onReceiveProgress, queryParameters: {"object": objectName});

  upload(
    String bucket,
    String objectName,
    String pathName,
    String contentType,
    String contentLength,
    Function(int, int) onSendingProgress,
  ) async {
    Response response;
    response = await dio.post<String>(
      "https://storage.googleapis.com/upload/storage/v1/b/$bucket/o",
      data: pathName,
      options: Options(headers: {"Content-Type": contentType, "Content-Length": contentLength}),
      queryParameters: {"name": "objectName", "uploadType": "media"},
      onSendProgress: onSendingProgress,
    );
  }
}

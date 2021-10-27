abstract class Api {
  Future<Map> get(String uri, [Map<String, dynamic> paramter]);
  Future<Map> post(String uri, Map<String, dynamic> body, [Map<String, dynamic> paramters]);
}

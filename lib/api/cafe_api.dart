import 'package:admin_dashboard/services/local_storage.dart';
import 'package:dio/dio.dart';

class CafeApi {
  static Dio _dio = Dio();

  static void configureDio() {
    // Url base
    _dio.options.baseUrl = 'http://localhost:8080/api';

    // Configure headers
    _dio.options.headers = {
      'x-token': LocalStorage.prefs.getString('token') ?? ''
    };
  }

  static Future httpGet(String segment) async {
    try {
      final response = await _dio.get(segment);

      return response.data;
    } catch (err) {
      print(err);
      throw ('Error in httpGet');
    }
  }

  static Future httpPost(String segment, Map<String, dynamic> data) async {
    final formData = FormData.fromMap(data);

    try {
      final response = await _dio.post(segment, data: formData);

      return response.data;
    } catch (err) {
      print(err);
      throw ('Error in httpPost');
    }
  }
}

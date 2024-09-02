import 'package:dio/dio.dart';

class Api {
  static final authHeader = {'accept': "application/json"};

  Dio api = Dio(
    BaseOptions(
      baseUrl: "https://fakestoreapi.com/",
      contentType: "application/json",
    ),
  );
  Future<dynamic> request({
    required String url,
    required RequestMethod method,
    Object? payload,
    required Map<String, dynamic> header,
  }) async {
    try {
      Response<dynamic> response;
      switch (method) {
        case RequestMethod.get:
          response = await api.get(url,
              data: payload, options: Options(headers: header));
          break;
        case RequestMethod.post:
          response = await api.post(url,
              data: payload, options: Options(headers: header));
          break;
        case RequestMethod.patch:
          response = await api.patch(url,
              data: payload, options: Options(headers: header));
          break;
        case RequestMethod.delete:
          response = await api.delete(url, options: Options(headers: header));
          break;
      }

      if ((response.data is Map) || (response.data is List)) {
        return response.data;
      } else {
        return (response.data is List) ? [] : null;
      }
    } on DioException {
      return null;
    }
  }
}

enum RequestMethod { get, post, patch, delete }

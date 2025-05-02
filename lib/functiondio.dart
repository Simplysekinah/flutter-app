import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:onboard/main.dart';

Future<Map<String, dynamic>> result() async {
  final _axios = axios();

  try {
    Response response = await _axios.get('/recipe');
    print(response.data);
    Map<String, dynamic> res = response.data;

    // print(res);
    return {'data': res['recipes']};
    // return {'data': response.data};
  } on DioException catch (e) {
    print('Dio error: ${e.message}');
    return {'status': 'failed', 'message': e.message};
  } catch (e) {
    print('Unexpected error: $e');
    return {'error': e.toString()};
  }
}

Dio axios([String? token]) {
  final dio = Dio();
  String baseURL = dotenv.env['BASEURL'] ?? '';
  dio.options.baseUrl = baseURL;
  dio.options.connectTimeout = const Duration(seconds: 5);
  dio.options.sendTimeout = const Duration(seconds: 5);
  dio.options.extra = {
    'id': ''
  }; // You can change or remove this based on your logic

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        options.headers['accept'] = 'application/json';
        if (token != null) {
          options.headers['Authorization'] = 'Bearer $token';
        }
        handler.next(options);
      },
    ),
  );

  return dio;
}

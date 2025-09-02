import 'package:dio/dio.dart';
import '../../core/config/flavour_manager.dart';

class DioClient {
  static final Dio dio = Dio(BaseOptions(
    baseUrl: FlavorManager.env?.baseUrl ?? "",
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Accept': 'application/json',
    },
  ))
    ..interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        // Add headers like Authorization
        //options.headers['Authorization'] = 'Bearer your_access_token';
        print('--> ${options.method} ${options.uri}');
        return handler.next(options); // continue
      },
      onResponse: (response, handler) {
        print('<-- ${response.statusCode} ${response.requestOptions.uri}');
        return handler.next(response); // continue
      },
      onError: (DioException e, handler) {
        print('❌ Error: ${e.message}');
        return handler.next(e); // continue
      },
    ))
    ..interceptors.add(LogInterceptor(
  request: true,
  requestHeader: true,
  requestBody: true,
  responseBody: true,
  responseHeader: false,
  error: true,
));
}

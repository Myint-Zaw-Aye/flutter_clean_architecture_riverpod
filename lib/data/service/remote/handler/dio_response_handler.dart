import 'dart:convert';
import 'package:dio/dio.dart';
import '../../../../core/app_exception.dart';

class DioResponseHandler {
  /// Handle successful/failed responses (like ReturnResponse in http)
  static dynamic handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
        // Ensure JSON decoding for string responses
        if (response.data is String) {
          return jsonDecode(response.data);
        }
        return response.data;

      case 400:
        throw BadRequestException(response.data.toString());

      case 401:
      case 403:
        throw UnauthorisedException(response.data.toString());

      case 500:
      default:
        throw FetchDataException(
          'Error occurred while Communication with Server '
          'with StatusCode : ${response.statusCode}',
        );
    }
  }

  /// Map Dio errors into your custom exceptions
  static AppException handleError(DioException error) {
    if (error.response != null) {
      switch (error.response?.statusCode) {
        case 400:
          return BadRequestException(error.response?.data.toString());
        case 401:
        case 403:
          return UnauthorisedException(error.response?.data.toString());
        case 500:
        default:
          return FetchDataException(
            'Error with StatusCode: ${error.response?.statusCode}',
          );
      }
    } else {
      return FetchDataException('No Internet connection');
    }
  }
}

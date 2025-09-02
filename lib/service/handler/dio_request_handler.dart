import 'dart:convert';
import 'package:clean_architecture_riverpod/service/exception/http_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'handler.dart';

class DioRequestHandler {
  /// Generic request handler with parser
  static Future<T> handleRequest<T>(
    Future<Response> Function() request,
    T Function(dynamic json) parser,
  ) async {
    try {
      final response = await request();
      final data = DioResponseHandler.handleResponse(response);
      final dynamic decodedData = data is String ? json.decode(data) : data;

      debugPrint("✅ Data: $decodedData");

      return parser(decodedData);
    } on DioException catch (e) {
      debugPrint('❌ Dio Exception: ${e.response}');
      throw HttpException('Request failed: ${e.response}');
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw HttpException('Request failed: $e');
    }
  }


  static Future<T> handleTokenRequest<T>(
    Future<Response> Function(String token) request,
    Future<String> Function() tokenProvider,
    T Function(dynamic json) parser,
  ) async {
    final token = await tokenProvider();
    try {
      final response = await request(token);

      final data = DioResponseHandler.handleResponse(response);
      final dynamic decodedData = data is String ? json.decode(data) : data;

      debugPrint("✅ Data: $decodedData");

      return parser(decodedData);
    } on DioException catch (e) {
      debugPrint('❌ Dio Exception: ${e.response}');
      throw HttpException('Request failed: ${e.response}');
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      throw HttpException('Request failed: $e');
    }
  }
}

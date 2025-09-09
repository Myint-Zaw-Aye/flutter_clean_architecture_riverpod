import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../../../core/app_exception.dart';
import '../../../../core/either.dart';
import 'handler.dart';


class DioRequestHandler {
  /// Core handler used by both request types
  static Future<Either<AppException, T>> _handle<T>(
    Future<Response> Function() request,
    T Function(dynamic json) parser,
  ) async {
    try {
      final response = await request();
      final data = DioResponseHandler.handleResponse(response);
      final decodedData = data is String ? json.decode(data) : data;

      debugPrint("✅ Data: $decodedData");

      return Either.right(parser(decodedData));
    } on DioException catch (e) {
      debugPrint('❌ Dio Exception: ${e.message}');
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.sendTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        return Either.left(AppException("Request failed: Connection timeout"));
      }
      return Either.left(AppException('Request failed: ${e.message}'));
    } catch (e) {
      debugPrint('❌ Unexpected error: $e');
      return Either.left(AppException('Request failed: $e'));
    }
  }

  /// Normal request
  static Future<Either<AppException, T>> handleRequest<T>(
    Future<Response> Function() request,
    T Function(dynamic json) parser,
  ) =>
      _handle(request, parser);

  /// Token-based request
  static Future<Either<AppException, T>> handleTokenRequest<T>(
    Future<Response> Function(String token) request,
    Future<String> Function() tokenProvider,
    T Function(dynamic json) parser,
  ) async {
    final token = await tokenProvider();
    return _handle(() => request(token), parser);
  }
}
import 'dart:io';

import 'package:dio/dio.dart';

class DioExceptions implements Exception {
  String? message;

  DioExceptions.fromDioError(DioError dioError) {
    if (dioError.error is SocketException) {
      message = 'Please verify your internet connection';
      return;
    }

    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with API server";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with API server";
        break;
      case DioErrorType.response:
        message = _handleError(
          dioError.response!.statusCode,
          dioError.response!.data,
        );
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with API server";
        break;

      default:
        message = "Something went wrong";
        break;
    }
  }

  String _handleError(int? statusCode, dynamic error) {
    if (error != null && error is Map) {
      final parsedJson = error as Map<String, dynamic>;

      if (parsedJson.containsKey('error')) {
        return parsedJson['error'] is String
            ? parsedJson['error']
            : parsedJson['error'].first['msg'].toString();
      }
    }

    switch (statusCode) {
      case 400:
        return 'Bad request';
      case 404:
        return error["message"];
      case 500:
        return 'Internal server error';
      case 503:
        return 'Service unavailable';
      default:
        return 'Oops something went wrong';
    }
  }

  @override
  String toString() => message!;
}
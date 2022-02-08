import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_clean_architecture/src/core/utils/constants.dart';
import 'package:flutter_clean_architecture/src/data/api/result.dart';

import 'dio_exceptions.dart';

class DioClient {
  static const int timeOutInSeconds = 50;

  BaseOptions options = BaseOptions(
    connectTimeout: 10000,
    receiveTimeout: 10000,
  );
  late final Dio dio = Dio(options);

  //GET
  Future<Result> get(String? api) async {
    var url = baseUrl + api!;
    dio.options.headers['Content-Type'] = Headers.jsonContentType;
    try {
      Response response = await dio.get(
        url,
        options: Options(contentType: Headers.jsonContentType),
      );
      return Result.success(response.data);
    } on DioError catch (error) {
      if (error.error != null && error.error is SocketException) {
        log(error.error.message);
        return Result.networkError('Please verify your internet connection');
      }
      var errorMessage = DioExceptions.fromDioError(error).toString();
      log(error.response?.data.toString() ?? error.message);
      return Result.error(errorMessage);
    } catch (err) {
      log(err.toString());
      return Result.error(err.toString());
    }
  }
}


import 'dart:developer';
import 'api_response.dart';
import 'package:dio/dio.dart';
import 'package:movies_task/utils/app_consts.dart';

typedef GetUserAuthTokenCallback = Future<String?> Function();

class NetworkClient {
  static const contentTypeJson = 'application/json';

  final GetUserAuthTokenCallback getUserAuthToken;
  final Dio _restClient;

  NetworkClient({
    required GetUserAuthTokenCallback getUserAuthToken,
  })  : getUserAuthToken = getUserAuthToken,
        _restClient = _createDio(AppConsts.baseUrl);

  Future<ApiResponse<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    bool? sendUserAuth,
  }) async {
    try {
      final resp = await _restClient.get(
        path,
        queryParameters: queryParameters,
        options: await _createDioSettings(
          contentType: contentTypeJson,
          sendUserAuth: sendUserAuth,
        ),
      );

      final jsonData = resp.data;
      return ApiResponse<T>.success(
        statusCode: resp.statusCode,
        rawData: jsonData,
      );
    } on DioException catch (e) {
      return _createResponse<T>(e);
    }
  }

  Future<ApiResponse<T>> post<T>(
      String path, {
        data,
        Map<String, dynamic>? queryParameters,
        bool? sendUserAuth,
      }) async {
    try {
      final resp = await _restClient.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: await _createDioSettings(
          contentType: contentTypeJson,
          sendUserAuth: sendUserAuth,
        ),
      );

      final jsonData = resp.data;
      return ApiResponse<T>.success(
        statusCode: resp.statusCode,
        rawData: jsonData,
      );
    } on DioException catch (e) {
      return _createResponse<T>(e);
    }
  }

  ApiResponse<T> _createResponse<T>(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiResponse<T>.error(
          statusCode: 500,
          message: 'Failed to connected to server',
        );
      case DioExceptionType.sendTimeout:
        return ApiResponse<T>.error(
          statusCode: 500,
          message: 'Failed to connected to server',
        );
      case DioExceptionType.receiveTimeout:
        return ApiResponse<T>.error(
          statusCode: 500,
          message: 'Server not responding',
        );
      case DioExceptionType.badResponse:
        log('THIS IS THE ERROR ${error.type} ${error.message} ${error.error} ${error.response}');
        // ignore: unused_local_variable
        final jsonResp = error.response!.data;
        return ApiResponse<T>.error(
          statusCode: error.response?.statusCode,
        );
      case DioExceptionType.cancel:
        return ApiResponse<T>.error(
          statusCode: 500,
          message: 'Request canceled',
        );
      case DioExceptionType.unknown:
        return ApiResponse<T>.error(
          statusCode: 500,
          message: 'Something went wrong, try again later',
        );
      case DioExceptionType.badCertificate:
        return ApiResponse<T>.error(
          statusCode: 500,
          message: 'Something went wrong, try again later',
        );
      case DioExceptionType.connectionError:
        return ApiResponse<T>.error(
          statusCode: 500,
          message: 'Connection Error',
        );
    }
  }

  Future<Options> _createDioSettings({
    required String contentType,
    bool? sendUserAuth,
  }) async {
    final Map<String, String> headers;

    headers = {
      "Content-Type": "application/json",
      "Authorization": "Bearer ${AppConsts.appToken}",
    };

    final options = Options(
      headers: headers,
      contentType: contentType,
    );
    return options;
  }

  static Dio _createDio(String baseUrl) {
    final options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    );
    final dio = Dio(options);
    dio.interceptors.add(LogInterceptor(
      requestHeader: false,
      responseBody: true,
    ));
    return dio;
  }
}

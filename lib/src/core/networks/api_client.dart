import 'package:dio/dio.dart';
import 'exceptions/exceptions.dart';
import 'exceptions/failures.dart';

abstract class ApiClient {
  Future<dynamic> get(
    String uri, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  });

  Future<dynamic> post(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  });

  Future<dynamic> put(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  });

  Future<dynamic> patch(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  });

  Future<dynamic> delete(
    String uri, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
  });

  Future<dynamic> download(String uri, dynamic path);

  static Future<T> guard<T>(Future<T> Function() future) async {
    try {
      return await future();
    } on BadRequestException catch (err, stack) {
      throw BadRequestFailure(
        stackTrace: stack,
      );
    } on InternalServerErrorException catch (err, stack) {
      throw InternalServerErrorFailure(
        stackTrace: stack,
      );
    } on UnauthorizedException catch (err, stack) {
      throw UnauthorizedFailure(
        stackTrace: stack,
      );
    } on NotFoundException catch (err, stack) {
      throw NotFoundFailure(
        stackTrace: stack,
      );
    } on ConnectionTimeoutException catch (err, stack) {
      throw ConnectionTimeoutFailure(
        stackTrace: stack,
      );
    } on BadResponseException catch (err, stack) {
      throw BadResponseFailure(
        stackTrace: stack,
      );
    } on FoundException catch (err, stack) {
      throw FoundFailure(
        headers: err.headers,
        stackTrace: stack,
      );
    } on ConnectionErrorException catch (err, stack) {
      throw ConnectionErrorFailure(
        stackTrace: stack,
      );
    } on TawuniyaException catch (err, stack) {
      throw TawuniyaFailure(
        stackTrace: stack,
      );
    } catch (err, stack) {
      throw UnknownFailure(
        stackTrace: stack,
      );
    }
  }
}

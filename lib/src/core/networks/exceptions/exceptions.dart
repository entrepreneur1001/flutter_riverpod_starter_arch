import 'package:dio/dio.dart';

class BadRequestException extends DioException {
  BadRequestException(RequestOptions r, [String? error])
      : super(requestOptions: r, error: error);
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r, [String? error])
      : super(requestOptions: r, error: error);
}

class ConflictException extends DioException {
  ConflictException(RequestOptions r, [String? error])
      : super(requestOptions: r, error: error);
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions r, [String? error])
      : super(requestOptions: r, error: error);
}

class NotFoundException extends DioException {
  NotFoundException(RequestOptions r, [String? error])
      : super(requestOptions: r, error: error);
}

class ConnectionTimeoutException extends DioException {
  ConnectionTimeoutException(RequestOptions r, [String? error])
      : super(requestOptions: r, error: error);
}

class SendTimeoutException extends DioException {
  SendTimeoutException(RequestOptions r, [String? error])
      : super(requestOptions: r, error: error);
}

class ReceiveTimeoutException extends DioException {
  ReceiveTimeoutException(RequestOptions r, [String? error])
      : super(requestOptions: r, error: error);
}

class BadCertificateException extends DioException {
  BadCertificateException(RequestOptions r, [String? error])
      : super(requestOptions: r, error: error);
}

class BadResponseException extends DioException {
  BadResponseException(RequestOptions r, [String? error])
      : super(requestOptions: r, error: error);
}

class FoundException extends DioException {
  final Map<String, dynamic> headers;

  FoundException(RequestOptions r, this.headers, [String? error])
      : super(requestOptions: r, error: error);
}

class CancelException extends DioException {
  CancelException(RequestOptions r, [String? error])
      : super(requestOptions: r, error: error);
}

class ConnectionErrorException extends DioException {
  ConnectionErrorException(RequestOptions r, [String? error])
      : super(requestOptions: r, error: error);
}

class UnknownException extends DioException {
  UnknownException(RequestOptions r, [String? error])
      : super(requestOptions: r, error: error);
}

class ValidationException extends DioException {
  ValidationException(RequestOptions r, [String? error])
      : super(requestOptions: r, error: error);
}

class TawuniyaException implements Exception {
  TawuniyaException([this.error]);

  final String? error;
}

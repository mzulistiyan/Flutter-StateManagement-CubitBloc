import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_cubit_statemanagement/domain/auth/login_request.dart';
import 'package:flutter_cubit_statemanagement/domain/auth/login_response.dart';

class AuthRepository {
  final Dio _dio = Dio();

  Future<Either<String, LoginResponse>> signInUserWithEmailAndPassword({
    required LoginRequest loginRequest,
  }) async {
    Response _response;
    try {
      _response = await _dio.post("https://reqres.in/api/login",
          data: loginRequest.toJson());
      LoginResponse _loginResp = LoginResponse.fromJson(_response.data);
      return right(_loginResp);
    } on DioError catch (e) {
      //Error Yang DIhasilkan Oleh DIO
      print(e.response!.statusCode);
      String errorMessage = e.response!.data.toString();
      switch (e.type) {
        case DioErrorType.connectTimeout:
          // TODO: Handle this case.
          break;
        case DioErrorType.sendTimeout:
          // TODO: Handle this case.
          break;
        case DioErrorType.receiveTimeout:
          // TODO: Handle this case.
          break;
        case DioErrorType.response:
          errorMessage = e.response!.data['error'];
          break;
        case DioErrorType.cancel:
          // TODO: Handle this case.
          break;
        case DioErrorType.other:
          // TODO: Handle this case.
          break;
      }

      return left(errorMessage);
    }
  }
}

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoginService {
  static Future<Response?> logIn(context) async {
    final Dio dio = Dio();
    final String baseUrl = 'http://10.0.2.2:8000/api';
    final String login = '/user/login';

    dio.options.baseUrl = baseUrl;
    try {
      final response = await dio.post(
        login,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
        data: {"phone": '1234567890', "password": 'passwor'},
      );

      log('Response data: ${response.data}');
      return response;
    } on DioException catch (e) {
      log('Dio error: ${e.response?.data ?? e.message}');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            // context.read<LocaleCubit>().state.localizedStrings['login']
            // ['invalidCredentials'] ??
            e.response!.statusMessage ?? 'Invalid credentials',
          ),
          backgroundColor: Colors.red,
        ),
      );
      return null;
    } catch (e) {
      log('Unexpected error: $e');
      return null;
    }
  }
}

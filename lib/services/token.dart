// // const String token = "your_token_here";
// //       dio.options.headers["Content-Type"] = "application/json";
// //       dio.options.headers["Accept"] = "application/json";
// //       dio.options.headers["Authorization"] = 'Bearer $token';
// import 'dart:developer';
// import 'package:dio/dio.dart';

// class Post {
//   final Dio dio = Dio();
//   final String baseUrl = 'http://10.0.2.2:8000/api';
//   final String login = '/user/login';

//   Future<Response?> createPost() async {
//     dio.options.baseUrl = baseUrl;
//     try {
//       final response = await dio.post(
//         login,
//         options: Options(
//           headers: {
//             'Content-Type': 'application/json',
//             'Accept': 'application/json',
//           },
//         ),
//         data: {"phone": '1234567890', "password": 'password'},
//       );

//       log('Response data: ${response.data}');
//       return response;
//     } on DioException catch (e) {
//       log('Dio error: ${e.response?.data ?? e.message}');
//       return null;
//     } catch (e) {
//       log('Unexpected error: $e');
//       return null;
//     }
//   }
// }

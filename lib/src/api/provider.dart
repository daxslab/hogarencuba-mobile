import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_flavor/flutter_flavor.dart';

class Provider {

    final Dio dio = Dio(
            BaseOptions(
                baseUrl: FlavorConfig.instance.variables["baseUrl"],
                connectTimeout: 120000,
                receiveTimeout: 120000,
            )
    );

    Future<Response> homes() async {
        dio.options.headers = {
            HttpHeaders.acceptHeader: "Application/json"
        };

        if (FlavorConfig.instance.environment != FlavorEnvironment.PROD) {
            dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
        }

        try {
            Response response = await dio.get("/api.json");
            return response;
        } on DioError catch (error) {
            throw Exception(error.message);
        }
    }
}
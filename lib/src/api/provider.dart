import 'dart:io';

import 'package:dio/dio.dart';

class Provider {
    
    final Dio dio = Dio(
        BaseOptions(
            baseUrl: "https://hogarencuba.com",
            connectTimeout: 120000,
            receiveTimeout: 120000,
        )
    );
    
    Future<Response> homes() async {
        dio.options.headers = {
            HttpHeaders.acceptHeader: "Application/json"
        };
        
        try {
            Response response = await dio.get("/api.json");
            return response;
        } on DioError catch (error) {
            throw Exception(error.message);
        }
    }
}
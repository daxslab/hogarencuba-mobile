import 'package:dio/dio.dart';

import 'provider.dart';

class Repository {
    final provider = Provider();
    
    Future<Response> homes() => provider.homes();
}
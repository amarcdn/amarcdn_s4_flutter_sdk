library amarcdn;

import 'package:dio/dio.dart';

class AmarCND {
  String apiKey;
  String apiSecretKey;
  String regionTitle;
  late Dio _dio;

  AmarCND({
    required this.apiKey,
    required this.apiSecretKey,
    required this.regionTitle,
  }) {
    _dio = Dio();
  }
}

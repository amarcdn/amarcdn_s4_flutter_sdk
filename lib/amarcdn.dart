library amarcdn_s4;

import 'package:dio/dio.dart';

import 'data/region_data.dart';
import 'models/region.dart';

class AmarCDN {
  String apiKey;
  String apiSecretKey;
  String regionTitle;
  late Dio _dio;

  AmarCDN({
    required this.apiKey,
    required this.apiSecretKey,
    required this.regionTitle,
  }) {
    _dio = Dio();
  }

  Future<Response> createBucket({
    required String bucketName,
    bool isPrivate = false,
  }) async {
    RegionModel regionModel = getRegionIdAsKey(regionTitle: regionTitle);

    Map<String, dynamic> header = <String, String>{
      'api-key': apiKey,
      'api-secret-key': apiSecretKey,
      'rid': regionModel.regionId,
    };

    FormData formData = FormData();
    formData.fields.add(MapEntry('bucket', bucketName));
    formData.fields.add(MapEntry('isPrivate', isPrivate ? 'YES' : 'NO'));
    formData.fields.add(MapEntry('region', regionModel.regionKey));

    Response response;

    var url = 'https://${regionModel.regionUrl}/bucket/create';

    try {
      response = await _dio.post(
        url,
        data: formData,
        options: Options(headers: header),
      );
      return response;
    } on DioError catch (error) {
      throw Exception(error.message);
    }
  }
}

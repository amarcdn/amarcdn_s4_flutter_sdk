library amarcdn_s4;

import 'dart:io';

import 'package:dio/dio.dart';

import 'data/region_data.dart';
import 'models/region.dart';

class AmarCDN {
  String apiKey;
  String apiSecretKey;
  String regionTitle;
  late Dio _dio;
  late Map<String, dynamic> header;
  late RegionModel regionModel;
  final chunkSize = 1024 * 1024; //1MB
  AmarCDN({
    required this.apiKey,
    required this.apiSecretKey,
    required this.regionTitle,
  }) {
    _dio = Dio();
    regionModel = getRegionIdAsKey(regionTitle: regionTitle);
    header = <String, String>{
      'api-key': apiKey,
      'api-secret-key': apiSecretKey,
      'rid': regionModel.regionId,
    };
  }

  Future<Response> createBucket({
    required String bucketName,
    bool isPrivate = false,
  }) async {
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

  Future<Response> getBucketList() async {
    Response response;

    var url = 'https://${regionModel.regionUrl}/bucket/list';

    try {
      response = await _dio.get(
        url,
        options: Options(headers: header),
      );
      return response;
    } on DioError catch (error) {
      throw Exception(error.message);
    }
  }

  Future<Response> deleteBucket(
      {required String bucketName, required String bucketId}) async {
    FormData formData = FormData();
    formData.fields.add(MapEntry('bucket', bucketName));
    formData.fields.add(MapEntry('bucketId', bucketId));
    formData.fields.add(MapEntry('region', regionModel.regionKey));

    Response response;

    var url = 'https://${regionModel.regionUrl}/bucket/delete';

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

  Stream<Response> _uploadFileAsChunk({
    required String bucketName,
    required String bucketId,
    required File file,
  }) async* {
    final fileName = file.path.split('/').last;
    final fileLength = await file.length();
    final int chunkCount = (fileLength / chunkSize).ceil();
    String attachId = '';

    try {
      Response? response;
      for (int i = 0; i < chunkCount; i++) {
        final start = i * chunkSize;
        final end =
            (start + chunkSize) > fileLength ? fileLength : start + chunkSize;

        final streamList = file.openRead(start, end);
        final int streamListLength = end - start;

        FormData formData = FormData();
        formData.fields.add(MapEntry('attachId', attachId));
        formData.fields.add(MapEntry('bucket', bucketName));
        formData.fields.add(MapEntry('bucketId', bucketId));
        formData.fields.add(MapEntry('region', regionModel.regionKey));
        formData.fields.add(MapEntry('totalChunk', '$chunkCount'));
        formData.fields.add(MapEntry('currentChunkNo', '${i + 1}'));

        final multitpartFile =
            MultipartFile(streamList, streamListLength, filename: fileName);
        formData.files.add(MapEntry('file', multitpartFile));
        response = await _dio.post(
            'https://global.amarcdn.com/file/upload-chunk',
            data: formData,
            options: Options(headers: header));

        attachId = response.data['body']['attachId'];
        yield response;
      }
    } catch (e) {
      rethrow;
    }
  }
}

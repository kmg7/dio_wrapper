import 'package:dio/dio.dart';
import 'package:dio_wrapper/dio_wrapper.dart';

class RequestManager {
  final Dio _dio = Dio();
  static RequestManager? _instance;
  static RequestManager get instance {
    _instance ??= RequestManager._init();
    return _instance!;
  }

  RequestManager._init();
  Future<Res?> request(
    String path, {
    dynamic data,
    required ReqOptions options,
    ReqQueryParams query,
    String? receieveProgress,
    String? sendProgress,
    bool debug = false,
  }) async {
    try {
      return await _dio.request(path,
          data: data,
          queryParameters: query,
          onSendProgress: (count, total) => {if (sendProgress != null) sendProgress = (count / total * 100).toStringAsFixed(0)},
          onReceiveProgress: (count, total) => {if (receieveProgress != null) receieveProgress = (count / total * 100).toStringAsFixed(0)},
          options: options);
    } on DioError catch (e) {
      if (debug) {
        rethrow;
      }
      return e.response;
    }
  }

  FormData multipartFormFromStream(Stream<List<int>> stream, int length) {
    FormData formData = FormData();
    formData.files.addAll([
      MapEntry("file", MultipartFile(stream, length)),
    ]);
    return formData;
  }
}

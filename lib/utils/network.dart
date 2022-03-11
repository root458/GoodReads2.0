part of training_utils;


class NetworkUtil {
  factory NetworkUtil() => _networkUtil;

  NetworkUtil.internal();

  final _logger = Logger();

  static final NetworkUtil _networkUtil = NetworkUtil.internal();

  static String? _getBearerToken() {
    return 'Super token';
  }

  Dio _getHttpClient() {
    final _dio = Dio(
      BaseOptions(
        baseUrl: TrainingConfig.instance!.values.baseDomain,
        contentType: 'application/json',
        headers: <String, dynamic>{'Accept': 'application/json'},
        connectTimeout: 60 * 1000,
        receiveTimeout: 60 * 1000,
      ),
    );

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          options.headers['Authorization'] = 'Bearer ${_getBearerToken()}';
          return handler.next(options);
        },
      ),
    );
    // (_dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (client) {
    //   client.badCertificateCallback =
    //       ((X509Certificate cert, String host, int port) => true);
    // };
    return _dio;
  }

  Future<Map<String, dynamic>> getReq(String url) async {
    try {
      final _response = await _getHttpClient().get<dynamic>(
        url,
      );
      final _responseBody = _response.data as Map<String, dynamic>;
      if (_responseBody.isEmpty) return <String, dynamic>{};
      return _responseBody;
    } on DioError catch (err) {
      if (DioErrorType.response == err.type) {
        _logger
          ..d('Error: ${err.toString()}')
          ..i('${err.response?.statusCode}')
          ..i('Error: ${err.response?.data}');
      } else if (DioErrorType.connectTimeout == err.type) {
        throw const SocketException('No internet connection');
      }
      throw Failure(message: 'Server error');
    }
  }

  Future<Map<String, dynamic>> postReq(
    String url, {
    required String body,
  }) async {
    try {
      final _response = await _getHttpClient().post<dynamic>(
        url,
        data: body,
      );

      final _responseBody = _response.data as Map<String, dynamic>;
      if (_responseBody.isEmpty) return <String, dynamic>{};
      return _responseBody;
    } on DioError catch (err) {
      if (DioErrorType.response == err.type) {
        _logger
          ..d('Error: ${err.toString()}')
          ..i('${err.response?.statusCode}')
          ..i('Error: ${err.response?.data}');

        if (err.response?.statusCode == 401) {
          throw Failure(message: 'Unauthenticated');
        }
      } else if (DioErrorType.connectTimeout == err.type) {
        throw Failure(message: 'No internet connection');
      }
      throw Failure(message: 'Server error');
    }
  }

  Future<Map<String, dynamic>> putReq(
    String url, {
    required String body,
  }) async {
    try {
      final _response = await _getHttpClient().put<dynamic>(
        url,
        data: body,
      );

      final _responseBody = _response.data as Map<String, dynamic>;
      if (_responseBody.isEmpty) return <String, dynamic>{};
      return _responseBody;
    } on DioError catch (err) {
      if (DioErrorType.response == err.type) {
        _logger
          ..d('Error: ${err.toString()}')
          ..i('${err.response?.statusCode}')
          ..i('Error: ${err.response?.data}');

        if (err.response?.statusCode == 401) {
          throw Failure(message: 'Unauthenticated');
        }
      } else if (DioErrorType.connectTimeout == err.type) {
        throw Failure(message: 'No internet connection');
      }
      throw Failure(message: 'Server error');
    }
  }

  Future<Map<String, dynamic>> multipartReq(
    String url, {
    required Map<String, dynamic> body,
    required String filePath,
  }) async {
    try {
      final _fileName = filePath.split('/').last;

      final _formData = FormData.fromMap(body);
      final _file = await MultipartFile.fromFile(
        filePath,
        filename: _fileName,
      );

      _formData.files.add(
        MapEntry(
          'media_file',
          _file,
        ),
      );

      final _dio = Dio(
        BaseOptions(
          baseUrl: TrainingConfig.instance!.values.baseDomain,
          contentType: 'multipart/form-data',
          connectTimeout: 600 * 1000,
          receiveTimeout: 600 * 1000,
          headers: <String, dynamic>{
            'Authorization': 'Bearer ${_getBearerToken()}',
            'Accept': '*/*',
          },
        ),
      );

      final _response = await _dio.post<dynamic>(
        url,
        data: _formData,
        onSendProgress: (int send, int total) {
          Logger().i((send / total) * 100);
        },
      );

      final _responseBody = _response.data as Map<String, dynamic>;
      if (_responseBody.isEmpty) return <String, dynamic>{};
      return _responseBody;
    } on DioError catch (err) {
      if (DioErrorType.response == err.type) {
        _logger
          ..d('Error: ${err.toString()}')
          ..i('${err.response?.statusCode}')
          ..i('Error: ${err.response?.data}');

        if (err.response?.statusCode == 401) {
          throw Failure(message: 'Unauthenticated');
        }
      } else if (DioErrorType.connectTimeout == err.type) {
        throw Failure(message: 'No internet connection');
      }
      throw Failure(message: 'Server error');
    }
  }
}

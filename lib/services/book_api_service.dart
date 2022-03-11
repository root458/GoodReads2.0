part of training_services;

abstract class BookApiService {
  Future<List<BookItem>> getItems();
  Future<List<BookItem>> addItem({
    required BookItemDTO bookItemDTO,
  });
}

class BookApiServiceImpl implements BookApiService {
  final _baseUrl = TrainingConfig.instance!.values.baseDomain;

  @override
  Future<List<BookItem>> getItems() async {
    final _bookApiUrl = '$_baseUrl/b/OT4T';
    try {
      final _resp = await _networkUtil.getReq(_bookApiUrl);

      return BookItemResult.fromJson(_resp).data;
    } on FormatException {
      throw Failure(
        message: 'Bad response format.',
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<BookItem>> addItem({required BookItemDTO bookItemDTO}) async {
    final _bookApiUrl = '$_baseUrl/b/OT4T';
    try {
      final _resp = await _networkUtil.postReq(
        _bookApiUrl,
        body: bookItemDTO.toString(),
      );

      return BookItemResult.fromJson(_resp).data;
    } on FormatException {
      throw Failure(
        message: 'Bad response format.',
      );
    } catch (e) {
      rethrow;
    }
  }
}

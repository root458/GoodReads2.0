part of training_models;


@freezed
class BookItemDTO with _$BookItemDTO {
  factory BookItemDTO({
    required String author,
    required String title,
    required int year,
  }) = _BookItemDTO;

  factory BookItemDTO.fromJson(Map<String, dynamic> json) =>
      _$BookItemDTOFromJson(json);
}

@freezed
class BookItemResult with _$BookItemResult {
  factory BookItemResult(
    List<BookItem> data,
  ) = _BookItemResult;

  factory BookItemResult.fromJson(Map<String, dynamic> json) =>
      _$BookItemResultFromJson(json);
}

@freezed
class BookItem with _$BookItem {
  factory BookItem(
    String author,
    String country,
    String imageLink,
    String language,
    String link,
    int pages,
    String title,
    int year,
  ) = _BookItem;

  factory BookItem.fromJson(Map<String, dynamic> json) =>
      _$BookItemFromJson(json);
}

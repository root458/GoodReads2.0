part of 'get_books_cubit.dart';

@freezed
class GetBooksState with _$GetBooksState {
  const factory GetBooksState.initial() = _Initial;
  const factory GetBooksState.loading() = _Loading;
  const factory GetBooksState.loaded(List<BookItem> books) = _Loaded;
  const factory GetBooksState.error(String message) = _Error;
}

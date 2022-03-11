part of 'post_book_cubit.dart';

@freezed
class PostBookState with _$PostBookState {
  const factory PostBookState.initial() = _Initial;
  const factory PostBookState.sending() = _Sending;
  const factory PostBookState.sent(List<BookItem> books) = _Sent;
  const factory PostBookState.error(String message) = _Error;
}

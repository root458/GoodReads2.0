import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_reads_app/models/_index.dart';
import 'package:good_reads_app/services/_index.dart';
import 'package:logger/logger.dart';

part 'post_book_state.dart';
part 'post_book_cubit.freezed.dart';

class PostBookCubit extends Cubit<PostBookState> {
  PostBookCubit({required BookApiService bookApiService})
      : super(const PostBookState.initial()) {
    _bookApiService = bookApiService;
  }

  late BookApiService _bookApiService;

  void loadFormPage() {
    emit(const PostBookState.initial());
  }

  Future postBooks(BookItemDTO bookItemDTO) async {
    emit(const PostBookState.sending());
    try {
      final _result = await _bookApiService.addItem(bookItemDTO: bookItemDTO);
      emit(PostBookState.sent(_result));
    } on Failure catch (err) {
      emit(PostBookState.error(err.message));
    } catch (e) {
      Logger().e(e);
      emit(
        const PostBookState.error('An unexepected error occured'),
      );
    }
  }
}

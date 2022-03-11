import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:good_reads_app/models/_index.dart';
import 'package:good_reads_app/services/_index.dart';
import 'package:logger/logger.dart';

part 'get_books_cubit.freezed.dart';
part 'get_books_state.dart';

class GetBooksCubit extends Cubit<GetBooksState> {
  GetBooksCubit({
    required BookApiService bookApiService,
  }) : super(const GetBooksState.initial()) {
    _bookApiService = bookApiService;
  }

  late BookApiService _bookApiService;

  Future getBooks() async {
    emit(const GetBooksState.loading());
    try {
      final _result = await _bookApiService.getItems();
      emit(GetBooksState.loaded(_result));
    } on Failure catch (err) {
      emit(GetBooksState.error(err.message));
    } catch (e) {
      Logger().e(e);
      emit(
        const GetBooksState.error('An unexepected error occured'),
      );
    }
  }
}

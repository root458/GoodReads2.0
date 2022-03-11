part of training_utils;

class Singletons {
  static final _bookApiService = BookApiServiceImpl();

  static List<BlocProvider> registerCubits() => [
        BlocProvider<PostBookCubit>(
          create: (context) => PostBookCubit(
            bookApiService: _bookApiService,
          ),
        ),
        BlocProvider<GetBooksCubit>(
          create: (context) => GetBooksCubit(
            bookApiService: _bookApiService,
          ),
        ),
      ];
}

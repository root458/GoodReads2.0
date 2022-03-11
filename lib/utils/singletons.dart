part of training_utils;

class Singletons {
  static final _bookApiService = BookApiServiceImpl();

  static List<BlocProvider> registerCubits() => [
        BlocProvider<GetBooksCubit>(
          create: (context) => GetBooksCubit(
            bookApiService: _bookApiService,
          ),
        ),
      ];
}

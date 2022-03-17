part of training_utils;

class Singletons {
  static final _bookApiService = BookApiServiceImpl();
  static final _hiveService = HiveServiceImpl();
  static final _authService = AuthServiceImpl(
    hiveService: _hiveService,
  );

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
        BlocProvider<GoogleSignInCubit>(
          create: (context) => GoogleSignInCubit(
            authService: _authService,
            hiveService: _hiveService,
          ),
        ),
      ];
}

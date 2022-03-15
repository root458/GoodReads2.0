part of training_services;

abstract class HiveService {
  Future<void> initBoxes();
  void clearPrefs();

  void persistToken(String token);
  String? retrieveToken();

  void persistProfile(AuthResult profile);
  AuthResult? retrieveProfile();
}

class HiveServiceImpl implements HiveService {
  @override
  Future<void> initBoxes() async {
    await Hive.initFlutter();
    Hive.registerAdapter(AuthResultAdapter());
    await Hive.openBox<dynamic>(TrainingConfig.instance!.values.authBox);
  }

  @override
  void clearPrefs() {
    Hive.box<dynamic>(TrainingConfig.instance!.values.authBox)
        .deleteAll(<String>[
      'access_token',
      'profile',
    ]);
  }

  @override
  void persistProfile(AuthResult profile) {
    Hive.box<dynamic>(TrainingConfig.instance!.values.authBox)
        .put('profile', profile);
  }

  @override
  AuthResult? retrieveProfile() {
    final _box = Hive.box<dynamic>(TrainingConfig.instance!.values.authBox);
    return _box.get('profile') as AuthResult?;
  }

  @override
  void persistToken(String token) {
    Hive.box<dynamic>(TrainingConfig.instance!.values.authBox)
        .put('access_token', token);
  }

  @override
  String? retrieveToken() {
    final _box = Hive.box<dynamic>(TrainingConfig.instance!.values.authBox);
    return _box.get('access_token') as String?;
  }
}

part of training_utils;

class TrainingValues {
  TrainingValues({
    required this.authBox,
    required this.baseDomain,
  });

  final String baseDomain;
  final String authBox;
}

class TrainingConfig {
  factory TrainingConfig({required TrainingValues values}) {
    return _instance ??= TrainingConfig._internal(values);
  }

  TrainingConfig._internal(this.values);

  final TrainingValues values;
  static TrainingConfig? _instance;

  static TrainingConfig? get instance => _instance;
}

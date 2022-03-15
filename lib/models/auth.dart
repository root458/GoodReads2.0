part of training_models;

@freezed
class UserAuthDTO with _$UserAuthDTO {
  factory UserAuthDTO({
    required String name,
    required String email,
  }) = _UserAuthDTO;

  factory UserAuthDTO.fromJson(Map<String, dynamic> json) =>
      _$UserAuthDTOFromJson(json);
}

@freezed
class AuthResult with _$AuthResult {
  factory AuthResult(
    @JsonKey(name: 'access_token') String accessToken,
    @JsonKey(name: 'user_uuid') String userUuid,
    String name,
    String email,
  ) = _AuthResult;

  factory AuthResult.fromJson(Map<String, dynamic> json) =>
      _$AuthResultFromJson(json);
}

class AuthResultAdapter extends TypeAdapter<AuthResult> {
  @override
  final typeId = 0;

  @override
  AuthResult read(BinaryReader reader) {
    return AuthResult.fromJson(
      Map<String, dynamic>.of(
        json.decode(reader.read() as String) as Map<String, dynamic>,
      ),
    );
  }

  @override
  void write(BinaryWriter writer, AuthResult obj) {
    writer.write(json.encode(obj.toJson()));
  }
}

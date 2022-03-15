part of training_services;

abstract class AuthService {
  Future<UserAuthDTO> signInWithGoogle();
  bool isLoggedIn();
  AuthResult? getProfile();

  Future<bool> logout();
}

class AuthServiceImpl implements AuthService {
  AuthServiceImpl({required HiveService hiveService}) {
    _hiveService = hiveService;
  }

  late HiveService _hiveService;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'profile',
      'email',
    ],
  );

  @override
  Future<UserAuthDTO> signInWithGoogle() async {
    final googleSignInAccount = await _googleSignIn.signIn();
    final googleSignInAuthentication =
        await googleSignInAccount?.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication?.idToken,
      accessToken: googleSignInAuthentication?.accessToken,
    );

    final authResult = await _auth.signInWithCredential(credential);
    final _user = authResult.user;
    if (_user != null) {
      assert(!_user.isAnonymous, 'User is not anonymous');
      return Future.value(
        UserAuthDTO(
          name: _user.displayName!,
          email: googleSignInAccount!.email,
        ),
      );
    } else {
      throw Failure(message: 'An error occured');
    }
  }

  @override
  Future<bool> logout() async {
    _hiveService.clearPrefs();
    await _googleSignIn.signOut();
    return true;
  }

  @override
  bool isLoggedIn() {
    final _user = _hiveService.retrieveProfile();
    if (_user != null) return true;
    return false;
  }

  @override
  AuthResult? getProfile() => _hiveService.retrieveProfile();
}

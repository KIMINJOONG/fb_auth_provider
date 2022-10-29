import 'package:fb_auth_provider/models/custom_error.dart';
import 'package:fb_auth_provider/providers/signin/signin_state.dart';
import 'package:fb_auth_provider/providers/signup/signup_state.dart';
import 'package:fb_auth_provider/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart';

class SignupProvider with ChangeNotifier {
  SignupState _state = SignupState.initial();

  SignupState get state => _state;

  final AuthRepository authRepository;

  SignupProvider({
    required this.authRepository,
  });

  Future<void> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    _state = _state.copyWith(signinStatus: SignupStatus.submitting);
    notifyListeners();
    try {
      await authRepository.signup(
        email: email,
        password: password,
        name: name,
      );
      _state = _state.copyWith(signinStatus: SignupStatus.success);
      notifyListeners();
    } on CustomError catch (e) {
      _state = _state.copyWith(signinStatus: SignupStatus.error, error: e);
      notifyListeners();
      rethrow;
    }
  }
}

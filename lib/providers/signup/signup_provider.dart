import 'package:fb_auth_provider/models/custom_error.dart';
import 'package:fb_auth_provider/providers/signin/signin_state.dart';
import 'package:fb_auth_provider/providers/signup/signup_state.dart';
import 'package:fb_auth_provider/repositories/auth_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:state_notifier/state_notifier.dart';

class SignupProvider extends StateNotifier<SignupState> with LocatorMixin {
  SignupProvider() : super(SignupState.initial());


  Future<void> signup({
    required String email,
    required String password,
    required String name,
  }) async {
    state = state.copyWith(signinStatus: SignupStatus.submitting);
    try {
      await read<AuthRepository>().signup(
        email: email,
        password: password,
        name: name,
      );
      state = state.copyWith(signinStatus: SignupStatus.success);
    } on CustomError catch (e) {
      state = state.copyWith(signinStatus: SignupStatus.error, error: e);
      rethrow;
    }
  }
}

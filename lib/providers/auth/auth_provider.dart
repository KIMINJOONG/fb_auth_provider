import 'package:fb_auth_provider/providers/auth/auth_state.dart';
import 'package:fb_auth_provider/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart' as fbAuth;
import 'package:state_notifier/state_notifier.dart';

class AuthProvider extends StateNotifier<AuthState> with LocatorMixin {
  AuthProvider() : super(AuthState.unknown());


  @override
  void update(Locator watch) {
    final user = read<fbAuth.User?>();

      if (user != null) {
        state = state.copyWith(
          authStatus: AuthStatus.authenticated,
          user: user,
        );
      } else {
        state = state.copyWith(authStatus: AuthStatus.unauthenticated);
      }
      super.update(watch);


  }
  // void update(fbAuth.User? user) {
  //   if (user != null) {
  //     _state = _state.copyWith(
  //       authStatus: AuthStatus.authenticated,
  //       user: user,
  //     );
  //   } else {
  //     _state = _state.copyWith(authStatus: AuthStatus.unauthenticated);
  //   }
  //
  //   print('authState : $_state}');
  //   notifyListeners();
  // }



  void signout() async {
    await read<AuthRepository>().signout();
  }
}

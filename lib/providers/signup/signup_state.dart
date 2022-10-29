import 'package:equatable/equatable.dart';

import '../../models/custom_error.dart';

enum SignupStatus {
  initial,
  submitting,
  success,
  error,
}

class SignupState extends Equatable {
  final SignupStatus signupStatus;
  final CustomError error;

  SignupState({
    required this.signupStatus,
    required this.error,
  });

  factory SignupState.initial() {
    return SignupState(
      signupStatus: SignupStatus.initial,
      error: CustomError(),
    );
  }


  @override
  List<Object> get props => [signupStatus, error];

  bool get stringify => true;

  SignupState copyWith({
    SignupStatus? signinStatus,
    CustomError? error,
  }) {
    return SignupState(
      signupStatus: signinStatus ?? this.signupStatus,
      error: error ?? this.error,
    );
  }
}

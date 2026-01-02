abstract class SocialLoginState {}

class SocialLoginInitialState extends SocialLoginState {}

class SocialLoginLodingState extends SocialLoginState {}

class SocialLoginSuccesState extends SocialLoginState {}

class SocialLoginErrorState extends SocialLoginState {
  final String error;
  SocialLoginErrorState(this.error);
}

class SocialChangeIconSuffixState extends SocialLoginState {}

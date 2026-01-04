
abstract class SocialLoginState {}

class SocialLoginInitialState extends SocialLoginState {}

class SocialLoginLodingState extends SocialLoginState {}

class SocialLoginSuccesState extends SocialLoginState {
  final String uId;
  SocialLoginSuccesState(this.uId);
}

class SocialLoginErrorState extends SocialLoginState {
  final String error;
  SocialLoginErrorState(this.error);
}

class SocialChangeIconSuffixState extends SocialLoginState {}

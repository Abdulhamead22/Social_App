abstract class SocialRegisterState {}

class SocialRegisterInitialState extends SocialRegisterState {}

class SocialRegisterLodingState extends SocialRegisterState {}

class SocialRegisterSuccesState extends SocialRegisterState {}

class SocialRegisterErrorState extends SocialRegisterState {
  final String error;
  SocialRegisterErrorState(this.error);
}

class SocialRegisterChangeIconSuffixState extends SocialRegisterState {}

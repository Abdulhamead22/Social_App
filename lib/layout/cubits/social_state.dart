abstract class SocialState {}

class SocialInitialState extends SocialState {}

class SocialGetUserLodingState extends SocialState{}

class SocialGetUserSuccessState extends SocialState {}

class SocialGetUserEroorState extends SocialState {
  final String error;
  SocialGetUserEroorState(this.error);
}

class SocialChangeNagBarState extends SocialState {}

class SocialNeewPostState extends SocialState {}

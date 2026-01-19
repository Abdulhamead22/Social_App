abstract class SocialState {}

class SocialInitialState extends SocialState {}

class SocialGetUserLodingState extends SocialState {}

class SocialGetUserSuccessState extends SocialState {}

class SocialGetUserEroorState extends SocialState {
  final String error;
  SocialGetUserEroorState(this.error);
}

class SocialChangeNagBarState extends SocialState {}

class SocialNeewPostState extends SocialState {}

class SocialProfileImagePickertSuccessState extends SocialState {}

class SocialProfileImagePickertEroorState extends SocialState {}

class SocialCoverImagePickertSuccessState extends SocialState {}

class SocialCoverImagePickertEroorState extends SocialState {}

class SocialUploadProfileImagetSuccessState extends SocialState {}

class SocialUploadProfileImagetEroorState extends SocialState {}

class SocialUploadCoverImagetSuccessState extends SocialState {}

class SocialUploadCoverImagetEroorState extends SocialState {}

class SocialUserUpdateEroorState extends SocialState {}

class SocialUserUpdateLoadingState extends SocialState {}

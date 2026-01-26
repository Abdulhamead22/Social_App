abstract class SocialState {}

class SocialInitialState extends SocialState {}

//user state

class SocialGetUserLodingState extends SocialState {}

class SocialGetUserSuccessState extends SocialState {}

class SocialGetUserErrorState extends SocialState {
  final String error;
  SocialGetUserErrorState(this.error);
}

class SocialChangeNagBarState extends SocialState {}

class SocialUserUpdateErrorState extends SocialState {}

class SocialUserUpdateLoadingState extends SocialState {}

class SocialGetAllUserLodingState extends SocialState {}

class SocialGetAllUserSuccessState extends SocialState {}

class SocialGetAllUserErrorState extends SocialState {
  final String error;
  SocialGetAllUserErrorState(this.error);
}

//profile and cover state

class SocialProfileImagePickertSuccessState extends SocialState {}

class SocialProfileImagePickertErrorState extends SocialState {}

class SocialCoverImagePickertSuccessState extends SocialState {}

class SocialCoverImagePickertErrorState extends SocialState {}

class SocialUploadProfileImagetSuccessState extends SocialState {}

class SocialUploadProfileImagetErrorState extends SocialState {}

class SocialUploadCoverImagetSuccessState extends SocialState {}

class SocialUploadCoverImagetErrorState extends SocialState {}

//post state

class SocialNeewPostState extends SocialState {}

class SocialCreatePostLodingState extends SocialState {}

class SocialCreatePostSuccessState extends SocialState {}

class SocialCreatePostErrorState extends SocialState {}

class SocialPostImagePickertSuccessState extends SocialState {}

class SocialPostImagePickertErrorState extends SocialState {}

class SocialRemovePostImageState extends SocialState {}

class SocialGetPostLodingState extends SocialState {}

class SocialGetPostSuccessState extends SocialState {}

class SocialGetPostErrorState extends SocialState {
  final String error;
  SocialGetPostErrorState(this.error);
}

class SocialLikePostSuccessState extends SocialState {}

class SocialLikePostErrorState extends SocialState {
  final String error;
  SocialLikePostErrorState(this.error);
}

class SocialCommentsPostSuccessState extends SocialState {}

class SocialCommentsPostErrorState extends SocialState {
  final String error;
  SocialCommentsPostErrorState(this.error);
}

class SocialGetCommentsSuccessState extends SocialState {}

//chat state

class SocialGetMessageSuccessState extends SocialState {}

class SocialGetMessageErrorState extends SocialState {}

class SocialSendMessageSuccessState extends SocialState {}

class SocialSendMessageErrorState extends SocialState {}
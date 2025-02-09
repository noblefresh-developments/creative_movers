part of 'feed_bloc.dart';

abstract class FeedState extends Equatable {
  const FeedState();
}

class FeedInitial extends FeedState {
  @override
  List<Object> get props => [];

  
}

class AddFeedLoadingState extends FeedState {
  @override
  List<Object> get props => [];
}

class AddFeedSuccessState extends FeedState {
  AddFeedResponse feedResponse;

  AddFeedSuccessState({required this.feedResponse});

  @override
  List<Object> get props => [feedResponse];
}

class AddFeedFaliureState extends FeedState {
  String error;

  AddFeedFaliureState({required this.error});

  @override
  List<Object> get props => [error];
}

//Get Feeds States
class FeedLoadingState extends FeedState {
  @override
  List<Object> get props => [];
}
class FeedSuccessState extends FeedState {
  FeedsResponse feedResponse;

  FeedSuccessState({required this.feedResponse});

  @override
  List<Object> get props => [feedResponse];
}
class FeedFaliureState extends FeedState {
  String error;

  FeedFaliureState({required this.error});

  @override
  List<Object> get props => [error];
}


//CommentStates
class CommentsLoadingState extends FeedState {
  @override
  List<Object> get props => [];
}
class CommentsSuccessState extends FeedState {
  PostCommentResponse postCommentsResponse;

  CommentsSuccessState({required this.postCommentsResponse});

  @override
  List<Object> get props => [postCommentsResponse];
}
class CommentsFaliureState extends FeedState {
  String error;

  CommentsFaliureState({required this.error});

  @override
  List<Object> get props => [error];
}

//LikesStates
class LikeLoadingState extends FeedState {
  @override
  List<Object> get props => [];
}
class LikeSuccessState extends FeedState {
  FeedsResponse feedResponse;

  LikeSuccessState({required this.feedResponse});

  @override
  List<Object> get props => [feedResponse];
}
class LikeFaliureState extends FeedState {
  String error;

  LikeFaliureState({required this.error});

  @override
  List<Object> get props => [error];
}

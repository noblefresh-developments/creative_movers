import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:creative_movers/data/remote/model/feed_response.dart';
import 'package:creative_movers/data/remote/model/feedsResponse.dart';
import 'package:creative_movers/data/remote/model/post_comments_response.dart';
import 'package:creative_movers/data/remote/model/server_error_model.dart';
import 'package:creative_movers/data/remote/model/state.dart';
import 'package:creative_movers/data/remote/repository/feed_repository.dart';
import 'package:creative_movers/helpers/http_helper.dart';
import 'package:equatable/equatable.dart';


part 'feed_event.dart';

part 'feed_state.dart';

class FeedBloc extends Bloc<FeedEvent, FeedState> {
  final FeedRepository feedRepository = FeedRepository(HttpHelper());

  FeedBloc() : super(FeedInitial()) {
    on<AddFeedEvent>(_mapAddFeedEventToState);
    on<GetFeedEvent>(_mapGetFeedEventToState);
    on<CommentEvent>(_mapCommentEventToState);
  }

  Future<FutureOr<void>> _mapAddFeedEventToState(
      AddFeedEvent event, Emitter<FeedState> emit) async {
    emit(AddFeedLoadingState());
    try {
      var response = await feedRepository.adFeed(
          type: event.type,
          // page_id: event.pageId!,
          content: event.content,
          media: event.media);
      if (response is SuccessState) {
        emit(AddFeedSuccessState(feedResponse: response.value));
      }
      if (response is ErrorState) {
        ServerErrorModel serverErrorModel = response.value;
        emit(AddFeedFaliureState(error: serverErrorModel.errorMessage));
      }
    } catch (e) {
      log(e.toString());
      emit(AddFeedFaliureState(error: "Ooops Something went wrong. $e."));
      // TODO
    }
  }

  Future<FutureOr<void>> _mapGetFeedEventToState(
      FeedEvent event, Emitter<FeedState> emit) async {
    try {
      emit(FeedLoadingState());
      var response = await feedRepository.getFeeds();
      if (response is SuccessState) {
        emit(FeedSuccessState(feedResponse: response.value));
      }
      if (response is ErrorState) {
        ServerErrorModel serverErrorModel = response.value;
        emit(FeedFaliureState(error: serverErrorModel.errorMessage));
      }
    } catch (e) {
      emit(FeedFaliureState(error: "Ooops Something went wrong."));
      // TODO
    }
  }

  //
  // Future<FutureOr<void>> _mapLikeEventToState(
  //     AddFeedEvent event, Emitter<FeedState> emit) async {
  //   try {
  //     emit(FeedLoadingState());
  //     var response = await feedRepository.adFeed(
  //         type: event.type,
  //         page_id: event.pageId!,
  //         content: event.content,
  //         media: event.media);
  //     if (response is SuccessState) {
  //       emit(FeedSuccessState(feedResponse: response.value));
  //     }
  //     if (response is ErrorState) {
  //       ServerErrorModel serverErrorModel = response.value;
  //       emit(FeedFaliureState(error: serverErrorModel.errorMessage));
  //     }
  //   } catch (e) {
  //     emit(FeedFaliureState(error: "Ooops Something went wrong."));
  //     // TODO
  //   }
  // }
  //
  // Future<FutureOr<void>> _mapAddCommentEventToState(
  //     AddFeedEvent event, Emitter<FeedState> emit) async {
  //   try {
  //     emit(FeedLoadingState());
  //     var response = await feedRepository.adFeed(
  //         type: event.type,
  //         page_id: event.pageId!,
  //         content: event.content,
  //         media: event.media);
  //     if (response is SuccessState) {
  //       emit(FeedSuccessState(feedResponse: response.value));
  //     }
  //     if (response is ErrorState) {
  //       ServerErrorModel serverErrorModel = response.value;
  //       emit(FeedFaliureState(error: serverErrorModel.errorMessage));
  //     }
  //   } catch (e) {
  //     emit(FeedFaliureState(error: "Ooops Something went wrong."));
  //     // TODO
  //   }
  // }
  //
  // Future<FutureOr<void>> _mapGetCommentsEventToState(
  //     AddFeedEvent event, Emitter<FeedState> emit) async {
  //   try {
  //     emit(FeedLoadingState());
  //     var response = await feedRepository.adFeed(
  //         type: event.type,
  //         page_id: event.pageId!,
  //         content: event.content,
  //         media: event.media);
  //     if (response is SuccessState) {
  //       emit(FeedSuccessState(feedResponse: response.value));
  //     }
  //     if (response is ErrorState) {
  //       ServerErrorModel serverErrorModel = response.value;
  //       emit(FeedFaliureState(error: serverErrorModel.errorMessage));
  //     }
  //   } catch (e) {
  //     emit(FeedFaliureState(error: "Ooops Something went wrong."));
  //     // TODO
  //   }
  // }
  // Future<FutureOr<void>> _mapGetLikesEventToState(
  //     AddFeedEvent event, Emitter<FeedState> emit) async {
  //   try {
  //     emit(FeedLoadingState());
  //     var response = await feedRepository.adFeed(
  //         type: event.type,
  //         page_id: event.pageId!,
  //         content: event.content,
  //         media: event.media);
  //     if (response is SuccessState) {
  //       emit(FeedSuccessState(feedResponse: response.value));
  //     }
  //     if (response is ErrorState) {
  //       ServerErrorModel serverErrorModel = response.value;
  //       emit(FeedFaliureState(error: serverErrorModel.errorMessage));
  //     }
  //   } catch (e) {
  //     emit(FeedFaliureState(error: "Ooops Something went wrong."));
  //     // TODO
  //   }
  // }


  Future<FutureOr<void>> _mapCommentEventToState(
      CommentEvent event, Emitter<FeedState> emit) async {
    try {
      emit(CommentsLoadingState());
      var response =
          await feedRepository.postComments(
              comment: event.comment,
              feed_id: event.feed_id);
      if (response is SuccessState) {
        emit(CommentsSuccessState(postCommentsResponse: response.value));
      }
      if (response is ErrorState) {
        ServerErrorModel serverErrorModel = response.value;
        emit(CommentsFaliureState(error: serverErrorModel.errorMessage));
      }
    } catch (e) {
      emit(CommentsFaliureState(error: "Ooops Something went wrong."));
      // TODO
    }
  }


}

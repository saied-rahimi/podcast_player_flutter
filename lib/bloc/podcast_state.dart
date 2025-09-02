part of 'podcast_cubit.dart';

@immutable
sealed class PodcastsState {}

class PodcastsChanged extends PodcastsState {
  PodcastsChanged({this.podcastList = const []});
  final List<BaseModel> podcastList;
}

class PodcastsHasError extends PodcastsState {
  PodcastsHasError({this.message = ''});
  final String message;
}

class PodcastsLoading extends PodcastsState {}

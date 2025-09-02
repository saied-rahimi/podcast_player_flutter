import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:podcast_player/graphql/graphql_docs.dart';
import 'package:podcast_player/model/podcast_model.dart';

part 'podcast_state.dart';

class PodcastsCubit extends Cubit<PodcastsState> {
  PodcastsCubit(this.client) : super(PodcastsLoading()) {
    refresh();
  }
  final GraphQLClient client;
  Future<void> refresh() async {
    final query = await client.query(QueryOptions(document: gql(queryAllPodcasts), fetchPolicy: FetchPolicy.networkOnly));
    if (query.hasException) {
      emit(PodcastsHasError(message: query.exception.toString()));
    }
    if (query.data != null) {
      final queryResult = query.data!['getPodcasts'] as List<dynamic>;
      final podcastList = queryResult.map((item) {
        final episodeList = item['episodsList'] as List<dynamic>;
        return PodcastModel.fromJson(item, episodeList.isNotEmpty);
      }).toList();
      emit(PodcastsChanged(podcastList: podcastList));
    }
  }
}

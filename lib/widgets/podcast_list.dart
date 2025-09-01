import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:podcast_player/graphql/graphql_docs.dart';
import 'package:podcast_player/model/podcast_model.dart';
import 'package:podcast_player/widgets/text_widget.dart';

import 'episodeList.dart';
import 'item_list_view.dart';

class PodcastList extends StatelessWidget {
  const PodcastList({super.key});

  @override
  Widget build(BuildContext context) {
    final title = 'Podcast List';
    return Material(
      child: Query(
        options: QueryOptions(document: gql(queryAllPodcasts)),
        builder: (QueryResult result, {VoidCallback? refetch, FetchMore? fetchMore}) {
          if (result.hasException) {
            return Center(child: Text(result.exception.toString()));
          }

          if (result.isLoading) {
            return Center(child: const Text('Loading'));
          }

          final queryResult = result.data!['getPodcasts'] as List<dynamic>;
          final podcastList = queryResult.map((item) => PodcastModel.fromJson(item)).toList();
          return Scaffold(
            appBar: podcastList.isEmpty ? AppBar(title: TitleText(title)) : null,

            body: Center(
              child: ItemListView(
                podcastList,
                title: title,
                onTap: (index) {
                  final episodeData = podcastList[index].episodsList;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => EpisodeList(episodeData, podcastList[index].id)));
                },
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcast_player/bloc/podcast_cubit.dart';
import 'package:podcast_player/model/podcast_model.dart';
import 'package:podcast_player/widgets/text_widget.dart';

import 'item_list_view.dart';

class EpisodeList extends StatelessWidget {
  const EpisodeList(this.podcastId, {super.key});
  final int podcastId;

  @override
  Widget build(BuildContext context) {
    final title = 'Episode List';
    return Scaffold(
      appBar: AppBar(
        title: TitleText(title),
        leading: BackButton(color: Colors.blue.shade400),
      ),
      body: SafeArea(
        child: BlocBuilder<PodcastsCubit, PodcastsState>(
          builder: (context, state) {
            if (state is PodcastsChanged) {
              final podcast = state.podcastList.firstWhere((p) => p.id == podcastId) as PodcastModel;
              final episodeData = podcast.episodsList;

              return Center(
                child: ItemListView(episodeData, title: title, podcastId: podcastId),
              );
            }
            if (state is PodcastsHasError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

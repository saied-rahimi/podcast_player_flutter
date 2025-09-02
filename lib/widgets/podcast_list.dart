import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:podcast_player/bloc/podcast_cubit.dart';
import 'package:podcast_player/model/podcast_model.dart';
import 'package:podcast_player/widgets/text_widget.dart';

import 'episode_list.dart';
import 'item_list_view.dart';

class PodcastList extends StatelessWidget {
  const PodcastList({super.key});

  @override
  Widget build(BuildContext context) {
    final title = 'Podcast List';

    return Material(
      child: BlocBuilder<PodcastsCubit, PodcastsState>(
        builder: (context, state) {
          if (state is PodcastsHasError) {
            return Center(child: Text(state.message));
          }
          if (state is PodcastsChanged) {
            final podcastList = state.podcastList as List<PodcastModel>;
            return Scaffold(
              appBar: podcastList.isEmpty ? AppBar(title: TitleText(title)) : null,
              floatingActionButton: IconButton(
                icon: Icon(Icons.restart_alt_rounded),
                onPressed: () {
                  context.read<PodcastsCubit>().refresh();
                },
              ),
              body: Center(
                child: ItemListView(
                  podcastList,
                  title: title,
                  onTap: (index) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EpisodeList(podcastList[index].id!)));
                  },
                ),
              ),
            );
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

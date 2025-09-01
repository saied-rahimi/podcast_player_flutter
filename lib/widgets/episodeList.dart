import 'package:flutter/material.dart';
import 'package:podcast_player/model/podcast_model.dart';
import 'package:podcast_player/widgets/text_widget.dart';

import 'item_list_view.dart';

class EpisodeList extends StatelessWidget {
  const EpisodeList(this.episodeData, this.podcastId, {super.key});
  final List<BaseModel> episodeData;
  final int podcastId;
  @override
  Widget build(BuildContext context) {
    final title = 'Episode List';
    return Scaffold(
      appBar: AppBar(
        title: TitleText(title),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).maybePop();
          },
          child: Icon(Icons.arrow_back_ios_new_outlined, color: Colors.blue.shade400),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ItemListView(episodeData, title: title, podcastId: podcastId),
        ),
      ),
    );
  }
}

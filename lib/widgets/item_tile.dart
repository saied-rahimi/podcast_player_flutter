import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:podcast_player/graphql/graphql_docs.dart';
import 'package:podcast_player/model/episode_model.dart';
import 'package:podcast_player/model/podcast_model.dart';
import 'package:podcast_player/widgets/text_widget.dart';

class ItemTile extends StatefulWidget {
  const ItemTile({super.key, required this.onTap, required this.item});

  final VoidCallback? onTap;
  final BaseModel item;

  @override
  State<ItemTile> createState() => _ItemTileState();
}

class _ItemTileState extends State<ItemTile> {
  bool isHovering = false;

  @override
  Widget build(BuildContext context) {
    final client = GraphQLProvider.of(context).value;

    final isEpisodePage = widget.item is EpisodeModel;

    final isPlayed = isEpisodePage && (widget.item as EpisodeModel).isPlayed;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.white.withAlpha(100), borderRadius: BorderRadius.circular(25)),
        child: MouseRegion(
          onEnter: (_) => setState(() => isHovering = true),
          onExit: (_) => setState(() => isHovering = false),

          child: InkWell(
            onTap: () => widget.onTap?.call(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Row(
                spacing: 20,
                children: [
                  CircleAvatar(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Text(widget.item.id.toString(), style: TextStyle(color: Colors.blue.shade300)),
                      ),
                    ),
                  ),
                  ItemTitleText(widget.item.title),
                  const Spacer(),
                  if (isHovering) ...[
                    InkWell(
                      onTap: () async {
                        if (isEpisodePage) {
                          await client.mutate(MutationOptions(document: gql(removeEpisode), variables: {'episodeId': widget.item.id}));
                        } else {
                          await client.mutate(MutationOptions(document: gql(removePodcast), variables: {'podcastId': widget.item.id}));
                        }
                      },
                      child: Icon(Icons.delete_forever_rounded, color: Colors.red),
                    ),
                    if (isEpisodePage && !isPlayed)
                      InkWell(
                        onTap: () {
                          client.mutate(MutationOptions(document: gql(markEpisodePlayed), variables: {'episodId': widget.item.id}));
                        },
                        child: Icon(Icons.check, color: Colors.blue),
                      ),
                  ] else if (isPlayed)
                    const Icon(Icons.check_circle, color: Colors.green),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

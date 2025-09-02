import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:podcast_player/bloc/podcast_cubit.dart';
import 'package:podcast_player/dialog/add_item_dialog.dart';
import 'package:podcast_player/graphql/graphql_docs.dart';
import 'package:podcast_player/model/podcast_model.dart';
import 'package:podcast_player/widgets/text_widget.dart';

import 'item_tile.dart';

class ItemListView extends StatelessWidget {
  const ItemListView(this.itemDate, {required this.title, this.onTap, this.createNewElement, this.podcastId, super.key});

  final List<BaseModel> itemDate;
  final String title;
  final void Function(int index)? onTap;
  final VoidCallback? createNewElement;
  final int? podcastId;

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    String createItem = podcastId == null ? createPodcast : createEpisode;
    final client = GraphQLProvider.of(context).value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (itemDate.isNotEmpty)
          SizedBox(
            width: screenSize.width * 0.7,
            child: Padding(
              padding: const EdgeInsets.only(left: 25, right: 15, bottom: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TitleText(title),
                  Spacer(),
                  InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (_) => AddItemDialog(
                          onCreate: (title) async {
                            if (podcastId != null) {
                              await client.mutate(MutationOptions(document: gql(createItem), variables: {'podcastId': podcastId, 'title': title}));
                            } else {
                              await client.mutate(MutationOptions(document: gql(createItem), variables: {'title': title}));
                            }
                            if (context.mounted) {
                              context.read<PodcastsCubit>().refresh();

                              Navigator.of(context).maybePop();
                            }
                          },
                        ),
                      );
                    },

                    child: Icon(Icons.add, color: Colors.blue.shade400),
                  ),
                ],
              ),
            ),
          ),
        if (itemDate.isEmpty)
          Expanded(
            child: Center(
              child: Column(
                spacing: 15,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'No Data yet, Try to add some',
                    style: TextStyle(fontWeight: FontWeight.w500, color: Colors.blue.shade400),
                  ),
                  Mutation(
                    options: MutationOptions(document: gql(createItem)),
                    builder: (runMutation, result) {
                      return InkWell(
                        onTap: () {
                          showDialog(
                            context: context,
                            builder: (_) => AddItemDialog(
                              onCreate: (title) async {
                                if (podcastId != null) {
                                  await client.mutate(
                                    MutationOptions(document: gql(createItem), variables: {'podcastId': podcastId, 'title': title}),
                                  );
                                } else {
                                  await client.mutate(MutationOptions(document: gql(createItem), variables: {'title': title}));
                                }
                                if (context.mounted) {
                                  context.read<PodcastsCubit>().refresh();

                                  Navigator.of(context).maybePop();
                                }
                              },
                            ),
                          );
                        },

                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade50,
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(width: 1.5, color: Colors.blue.shade100),
                          ),
                          child: Icon(Icons.add, color: Colors.blue.shade400),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        else
          SizedBox(
            width: screenSize.width * 0.7,
            child: DecoratedBox(
              decoration: BoxDecoration(
                color: Colors.blue.shade50,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(width: 1.5, color: Colors.blue.shade100),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: itemDate.length,
                  itemBuilder: (context, index) {
                    final item = itemDate[index];
                    return ItemTile(onTap: () => onTap?.call(index), item: item);
                  },
                ),
              ),
            ),
          ),
      ],
    );
  }
}

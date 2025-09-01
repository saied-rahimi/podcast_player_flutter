import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:podcast_player/widgets/podcast_list.dart';

void main() {
  final httpList = HttpLink('http://127.0.0.1:5000/');
  final client = ValueNotifier(
    GraphQLClient(
      link: httpList,
      cache: GraphQLCache(store: InMemoryStore()),
    ),
  );
  final graphqlApp = GraphQLProvider(client: client, child: MyApp());
  runApp(graphqlApp);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade400)),
      home: const PodcastList(),
    );
  }
}

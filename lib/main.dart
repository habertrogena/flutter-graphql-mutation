import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

import 'home_page.dart';

void main() {
  runApp(
    const MaterialApp(
      home: MyApp(),
      title: 'gql app',
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink('http://localhost:1995/graphql');
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(
          store: InMemoryStore(),
        ),
      ),
    );
    return GraphQLProvider(
      client: client,
      child: HomePage(),
    );
  }
}

// ignore: must_be_immutable


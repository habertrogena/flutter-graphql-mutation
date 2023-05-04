import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

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
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String createUser = '''
  mutation createUser(\$firstName: String!, \$lastName: String!, \$email: String!, \$password: String!) {
    create_user(objects: [{firstName: \$firstName, lastName: \$lastName, email: \$email, password: \$password}]) {
      affected_rows
    }
  }
''';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Graphql'),
      ),
      body: Mutation(
          options: MutationOptions(
            document: gql(createUser),
          ),
          builder: (RunMutation runMutation, QueryResult) {
            return Column(
              children: const [
                TextField(
                  decoration: InputDecoration(hintText: 'firstname'),
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'lastname'),
                ),
                TextField(
                  decoration: InputDecoration(hintText: 'email'),
                ),
              ],
            );
          }),
    );
  }
}

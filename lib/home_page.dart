import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomePage extends StatelessWidget {
  final TextEditingController firstNameController = TextEditingController();

  final TextEditingController lastNameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final String createUser = '''
  mutation createUser (\$input: UserInput){
  createUser (input: \$input) {
    email 
    firstName
    lastName
    
  }
}
''';

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('graphql mutation'),
        ),
        body: Mutation(
          options: MutationOptions(
            document: gql(createUser),
            onCompleted: (dynamic resultData) {
              print(resultData);
            },
            onError: (error) {
              print(error);
            },
          ),
          builder: (
            RunMutation runMutation,
            QueryResult? result,
          ) {
            return Column(
              children: [
                TextField(
                  decoration: const InputDecoration(hintText: 'firstname'),
                  controller: firstNameController,
                ),
                TextField(
                  decoration: const InputDecoration(hintText: 'lastname'),
                  controller: lastNameController,
                ),
                TextField(
                  decoration: const InputDecoration(hintText: 'email'),
                  controller: emailController,
                ),
                ElevatedButton(
                    onPressed: () {
                      // collect the first name, email and password
                      String firstName = firstNameController.value.text;
                      String lastName = lastNameController.value.text;
                      String email = emailController.value.text;

                      // create a user object
                      var user = {
                        'firstName': firstName,
                        'lastName': lastName,
                        'email': email,
                        'password': '12345678'
                      };
                      // add the user collected data to the user object
                      // run mutation
                      final createdUser = runMutation({'input': user});
                    },
                    child: const Text('Submit')),
                const Text(
                  "Result : \n \$(result.data?.data?.toString())",
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
